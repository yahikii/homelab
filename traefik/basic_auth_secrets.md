# Basic Auth Secret
The secret file is required for the `docker-compose.yml` to function properly.  

In the `traefik_auth.txt` is only the bcrypt password hash (htpasswd format) for Basic Auth stored. Nothing else.

To create the hash, execute the following command:

```bash
htpasswd -nbB admin YOUR_PASSWORD
```

Insert the full output line without whitespaces to the file. No further action needed. 
