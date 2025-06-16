# Déploiement d'une VM Windows avec IIS sur Azure via Terraform & GitLab CI/CD

## Terraform Azure - Structure technique

---

### Modules utilisés

| Module   | Ressources principales                                                                 |
|----------|------------------------------------------------------------------------------------------|
| Network  | VNet, Subnet, Public IP, NIC, NSG, NSG-NIC association                                  |
| Win_VM   | Windows VM, mot de passe aléatoire, **IIS via Custom Script Extension**                 |

---

### Backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name   = "rg"
    storage_account_name  = "tfstatefile"
    container_name        = "mycontainer"
    key                   = "terraform.tfstate"
  }
}
```

## Variables - Root module

| Nom                    | Type   | Description                    |
| ---------------------- | ------ | ------------------------------ |
| `prefix`               | string | Préfixe des ressources         |
| `ip_allocation`        | string | Méthode d'allocation IP        |
| `sec_rules`            | map    | Règles dynamiques du NSG       |
| `admin_username`       | string | Nom d'utilisateur admin VM     |
| `location`             | string | Région Azure                   |
| `resource_group_name`  | string | Groupe de ressources           |
| `vm_prefix`            | string | Préfixe de la VM               |
| `extension_prefix`     | string | Préfixe de l'extension         |
| `vm_size`              | string | Taille de la VM                |
| `caching`              | string | Mode de caching disque         |
| `storage_account_type` | string | Type de compte de stockage     |
| `publisher`            | string | Éditeur de l’image VM          |
| `offer`                | string | Famille de l’OS                |
| `sku`                  | string | SKU de l’OS                    |
| `version`              | string | Version de l’OS                |
| `IIS_publisher`        | string | Fournisseur pour extension IIS |
| `type`                 | string | Type de ressource extension    |

## Variables - Module Network
| Nom                   | Type   | Description               |
| --------------------- | ------ | ------------------------- |
| `location`            | string | Région Azure              |
| `resource_group_name` | string | Groupe de ressources      |
| `prefix`              | string | Préfixe des ressources    |
| `ip_allocation`       | string | Méthode d'allocation IP   |
| `sec_rules`           | map    | Règles de sécurité du NSG |

## Variables - Module Win_VM
| Nom                    | Type   | Description                |
| ---------------------- | ------ | -------------------------- |
| `admin_username`       | string | Nom d'utilisateur admin    |
| `location`             | string | Région Azure               |
| `resource_group_name`  | string | Groupe de ressources       |
| `extension_prefix`     | string | Préfixe extension IIS      |
| `vm_prefix`            | string | Préfixe VM                 |
| `vm_size`              | string | Taille VM                  |
| `caching`              | string | Caching disque             |
| `storage_account_type` | string | Type de compte de stockage |
| `publisher`            | string | Publisher image            |
| `offer`                | string | OS family                  |
| `sku`                  | string | SKU                        |
| `version`              | string | Version OS                 |
| `IIS_publisher`        | string | Publisher extension IIS    |
| `type`                 | string | Type extension             |

## CI/CD - GitLab (.gitlab-ci.yml)
```yaml
workflow:
    rules:
      -  if: $CI_COMMIT_BRANCH == "main" && $CI_COMMIT_TITLE =~ /gitlab$/
         when: always
      -  if: $CI_PIPELINE_SOURCE != "push" &&  $CI_PROJECT_VISIBILITY != "public"  
         when: never  

stages:
       - Validation
       - Previsualization
       - Application
       
default:
    image: 
        name: hashicorp/terraform:latest
        entrypoint:
           - /usr/bin/env
           - "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    
    before_script:
        - cd terraform_azure
        - terraform init 
    cache:
       key: terraform-cache
       paths:
       - terraform_azure/.terraform/

terraform_validate:
    stage: Validation
    script:
        - terraform validate    

terraform_plan:
    stage: Previsualization
    environment: 
        name: "Production"
    script:
        - terraform plan -out=myplan
        - pwd
        - ls -la 
    artifacts:
        name: "$CI_ENVIRONMENT_NAME-plan"
        paths: 
        - terraform_azure/myplan    

terraform_apply:
    stage: Application
    script:
        - terraform apply --auto-approve myplan
    rules:
      - if : $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
        when: manual  
```

## Conclusion

Ce projet permet de déployer automatiquement une infrastructure Azure complète avec réseau sécurisé et VM Windows configurée avec IIS. Le pipeline GitLab CI/CD assure un déploiement fiable et structuré.