library identifier: "pipeline-library@v1.5",
retriever: modernSCM(
  [
    $class: "GitSCMSource",
    remote: "https://github.com/redhat-cop/pipeline-library.git" 
  ]
)

 

// appName1 = "amisha-expense-tracker-backend-buildconfig"
// appName2= "amisha-expense-tracker-frontend-buildconfig"

 

pipeline {
    agent any
  environment {
    COMMIT_ID = sh (script: 'git rev-parse HEAD', returnStdout: true).trim().substring(0,3)
  }
    stages {
//         stage("Checkout") {
//             steps {
//                 checkout scm
//             }
//         }

        stage("Docker build backend"){
            steps {
              script{
                openshift.withCluster(){
                  openshift.withProject("$PROJECT_NAME"){
                    openshift.selector("bc","amisha-expense-tracker-backend-buildconfig").startBuild("--wait")
                  }
                }
              }
            }
        }

       stage("Tag backend image") {
       steps{
    tagImage([
            sourceImagePath: "amisha-jenkins",
            sourceImageName: "expense-tracker-backend",
            sourceImageTag : "latest",
            toImagePath: "amisha-jenkins",
            toImageName    : "expense-tracker-backend",
           // toImageTag     : "${env.BUILD_NUMBER}"
             toImageTag  : "$COMMIT_ID"

    ])
       }
       }
      
      
      stage("Docker build frontend"){
            steps {
              script{
                openshift.withCluster(){
                  openshift.withProject("$PROJECT_NAME"){
                    openshift.selector("bc","amisha-expense-tracker-frontend-buildconfig").startBuild("--wait")
                  }
                }
              }
            }
        }
      
      stage("Tag frontend image") {
       steps{
    tagImage([
            sourceImagePath: "amisha-jenkins",
            sourceImageName: "expense-tracker-frontend",
            sourceImageTag : "latest",
            toImagePath: "amisha-jenkins",
            toImageName    : "expense-tracker-frontend",
           // toImageTag     : "${env.BUILD_NUMBER}"
            toImageTag  : "$COMMIT_ID"
      

    ])
       }
       }
      
      stage("Trigger Deployment Update Pipeline"){
        steps{
         // build job:'tag-pipeline' , parameters: [string(name: 'DOCKERTAG',value: env.BUILD_NUMBER)]
           build job:'tag-pipeline' , parameters: [string(name: 'COMMIT_ID',value: env.BUILD_NUMBER)]
        }
      }
      
//       stage("deploy the application") {
//         steps {
//             script {
//                 openshift.withCluster() {
//                     openshift.withProject("$PROJECT_NAME") {
//                         echo "Using project: ${openshift.project()}"
//                          sh 'sh -x $WORKSPACE/backend-deployment.sh'
//                     }
//                  }
//             }
//         } 
//     }  
   }   
}   
