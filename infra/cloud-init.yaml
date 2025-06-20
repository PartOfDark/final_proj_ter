#cloud-config
users:
  - name: ubuntu
    groups: sudo
    shell: /bin/bash
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - "${ssh_key}"

package_update: true
packages:
  - docker.io
  - docker-compose-plugin
  - git

runcmd:
  - systemctl enable docker
  - systemctl start docker

  - curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  - echo 'export PATH=$HOME/yandex-cloud/bin:$PATH' > /etc/profile.d/yc_path.sh
  - chmod +x /etc/profile.d/yc_path.sh

  - mkdir -p /etc/profile.d && echo "" > /etc/profile.d/app_env.sh
  - git clone --depth 1 --branch "${repo_branch}" "${repo_url}" /opt/app && cd /opt/app/"${repo_path}"
  - yc config set service-account-key /etc/cloud/key.json
  - yc config set cloud-id "${cloud_id}"
  - yc config set folder-id "${folder_id}"
  - yc config set compute-default-zone "${zone}"
  - echo "export DB_HOST=$(yc lockbox secret version access latest --secret-id ${var.db_secret_ids[0]} --format json | jq -r '.entries[0].text_value')" >> /etc/profile.d/app_env.sh
  - echo "export DB_USER=$(yc lockbox secret version access latest --secret-id ${var.db_secret_ids[1]} --format json | jq -r '.entries[0].text_value')" >> /etc/profile.d/app_env.sh
  - echo "export DB_PASSWORD=$(yc lockbox secret version access latest --secret-id ${var.db_secret_ids[2]} --format json | jq -r '.entries[0].text_value')" >> /etc/profile.d/app_env.sh
  - echo "export DB_DATABASE=$(yc lockbox secret version access latest --secret-id ${var.db_secret_ids[3]} --format json | jq -r '.entries[0].text_value')" >> /etc/profile.d/app_env.sh
  - echo "export DB_TABLE=$(yc lockbox secret version access latest --secret-id ${var.db_secret_ids[4]} --format json | jq -r '.entries[0].text_value')" >> /etc/profile.d/app_env.sh
  - echo "export DB_ROOT_PASSWORD=$(yc lockbox secret version access latest --secret-id ${var.db_secret_ids[5]} --format json | jq -r '.entries[0].text_value')" >> /etc/profile.d/app_env.sh
  - chmod +x /etc/profile.d/app_env.sh && source /etc/profile.d/app_env.sh
  - docker compose pull && docker compose up -d

final_message: "App is up and running!"
