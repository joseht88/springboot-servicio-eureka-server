node {
   def mvnHome
   
   stage('Preparation') {
       git 'https://github.com/joseht88/springboot-servicio-eureka-server.git'
       mvnHome = tool 'MAVEN'
   }
   
   stage('Build') {
       try {
           sh "'${mvnHome}/bin/mvn' clean package -DskipTests"
       }catch (e){
           notifyStarted ("Build failed in Jenkins")
           throw e
       }
   }
   
   stage('Results') {
       try {
           archive 'target/*.jar'
       }catch (e){
           notifyStarted ("packaging failed in Jenkins")
           throw e
       }
   }
   
   stage('Deployment') {
       try {
			sh 'chown jenkins:jenkins /var/jenkins_home/workspace/springboot-servicio-eureka-server/runDeployment.sh'
			sh 'chmod +x /var/jenkins_home/workspace/springboot-servicio-eureka-server/runDeployment.sh'
           sh '/var/jenkins_home/workspace/springboot-servicio-eureka-server/runDeployment.sh'
       }catch (e){
           notifyStarted ("Deployment failed in Jenkins")
           throw e
       }
   }
   
   notifyStarted(" All is well ! Your code is tested, build, and deployed")

}

def notifyStarted(String message){
   slackSend (
        color: '#FFFF00',
        message:"${message}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
   )
}
