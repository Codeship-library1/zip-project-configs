# Zip Project Configs

From your CodeShip project's directory:

```
docker run --rm -it -v $(pwd):/data codeship/zip-project-configs:0.1.0 YOUR_COMMIT_ID
```

Docker process will zip git specified `codeship-service.yml` and `codeship-steps.yml` for delivery to support.
