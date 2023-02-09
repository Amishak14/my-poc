oc login --token="$OC_TOKEN" --server="$OC_SERVER"
oc project "$PROJECT_NAME"
oc apply -f https://github.com/Amishak14/tag-image/blob/main/my-folder/manifest.yaml
