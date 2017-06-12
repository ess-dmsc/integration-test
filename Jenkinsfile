// Set periodic trigger at 12:15 and 23:15, from Monday to Friday.
properties([
    pipelineTriggers([cron('15 10,21 * * 1-5')]),
])

node('kafka-client') {
    // Delete workspace when build is done.
    cleanWs()

    dir('code') {
        stage('Checkout') {
            checkout scm
        }
    }

    dir('build') {
        stage('Build') {
            sh "export PATH=$CMAKE3_ROOT/bin:$PATH:/opt/dm_group/usr/bin && \
                export LD_LIBRARY_PATH=/opt/dm_group/usr/lib && \
                ../code/efu/build.bash"
        }
    }

    dir('code') {
        stage('Stash') {
            stash includes: 'ansible/', name: 'ansible'
        }
    }
}

// This currently uses the artifact from the integration-test job.
node('integration-test') {
    dir('code') {
        stage('Unstash') {
            unstash 'ansible'
        }

        stage('Deploy') {
            sh "ansible-playbook -i ansible/hosts ansible/site.yml"
        }

        stage('Test') {
            sh "ansible-playbook -i ansible/hosts ansible/run_test.yml"
        }
    }
}
