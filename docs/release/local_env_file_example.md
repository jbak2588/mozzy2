# Local Env File Example

Do not commit real secrets.

If a local env file is needed for temporary development, create:

`.local/mozzy_dev_env.json`

Example:

```json
{
  "APP_ENV": "staging",
  "PAYMENT_MODE": "sandbox",
  "PRIVATE_BETA": "true",
  "PAYMENT_PRODUCTION_ENABLED": "false",
  "CRASHLYTICS_ENABLED": "true",
  "PERFORMANCE_ENABLED": "true",
  "BETA_CS_WHATSAPP": "628xxxxxxxxxx"
}
```

Do not put server API keys here.  
Gemini / payment / service account secrets must stay on the server.
