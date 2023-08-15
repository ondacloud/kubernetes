<h1 align="center"> Create Deployment </h1>

----
# Create Cluster.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-dpm
  namespace: dev-ns
  labels:
    app: dev
spec:
  replicas: 3
  selector:
    matchLabels:
      app: dev
  template:
    metadata:
      labels:
        app: dev
    spec:
      containers:
      - name: dev-container
        image: <image>
        ports:
        - containerPort: <Port>
```

# Create Deployment
```
kubectl apply -f deployment
```