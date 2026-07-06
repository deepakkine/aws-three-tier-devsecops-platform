alertmanager:
  config:
    global:
      smtp_smarthost: "smtp.gmail.com:587"
      smtp_from: "${alertmanager_email}"
      smtp_auth_username: "${alertmanager_email}"
      smtp_auth_password: "${alertmanager_email_password}"
      smtp_require_tls: true

    route:
      receiver: email
      routes:
        - matchers:
            - alertname="Watchdog"
          receiver: "null"

    receivers:
      - name: email
        email_configs:
          - to: "${alertmanager_email}"
            send_resolved: true

      - name: "null"