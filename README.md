# charts
Helm chart templates


### Environment
To use upload script, create a `.env` in root directory

```bash
CHARTMUSEUM_USER=<username>
CHARTMUSEUM_PASS=<password>
```

Then run in terminal
```bash
helm package ./template_directory

./scripts/upload.sh ./template_directory/***.tgz
```