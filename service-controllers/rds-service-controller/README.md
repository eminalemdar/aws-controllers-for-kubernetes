# RDS Service Controller Examples

In this folder, you can find general examples for creating RDS Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic RDS DB Instance creation:

```yaml
apiVersion: rds.services.k8s.aws/v1alpha1
kind: DBInstance
metadata:
  name: $DB_INSTANCE_ID #Change the DB Instance Name
spec:
  allocatedStorage: 5 #You can change the size of the storage
  dbInstanceClass: db.t3.micro #You can change the Instance Class
  dbInstanceIdentifier: $DB_INSTANCE_ID #Change the DB Instance Name
  dbSubnetGroupName: $DB_SUBNET_GROUP_NAME #Change the DB Subnet Group Name
  engine: postgres #You can change the DB Engine
  engineVersion: "14.1" #You can change the DB Engine version
  masterUsername: root #Change it accordingly
  masterUserPassword:
    namespace: $MASTER_USER_PASS_SECRET_NAMESPACE #Reference to the Kubernetes Secret
    name: $MASTER_USER_PASS_SECRET_NAME #Reference to the Kubernetes Secret
    key: $MASTER_USER_PASS_SECRET_KEY #Reference to the Kubernetes Secret
  multiAZ: False #You can change the configuration accordingly.
```

## Create the RDS Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the RDS Resource

```bash
kubectl delete dbinstance <dbinstance_name> #Change the db instance name accordingly and also change the resource name accordingly
```
