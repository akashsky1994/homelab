# Self-Hosted Bitwarden Server (Vaultwarden) 
Ready to use docker compose setup for Vaultwarden setup for password manager


### Setup
1. Setup your .env file using the template file ```.env.template``` 
2. For ssl certification, you will need to have your own domain with appropriate A record/ CNAME record in place
3. Run docker command

```
docker compose build
docker compose up -d
```
