# Version Control (Meta)

## Module 1
1. What is continuous integration?
    - Continuous Integration, or CI, is used to automate the integration of code changes from multiple developers into a single main stream. 
    - Using a workflow whereby small changes are merged frequently, often many times per day, will reduce the number of merge conflicts.
    - This process is widespread in test-driven software development strategies. 
    - CI is often used to automatically compile the project and run tests on every code change to ensure that the build remains stable and prevent regressions in functionality.

2. What is continous delivery?
    - Continuous Delivery is an advanced practice built on top of Continuous Integration. 
    - In this approach, once changes are merged into the main codebase, a Continuous Delivery pipeline automates the process of preparing the application for deployment. 
    - This process includes tasks like building the application, running tests, and packaging it for deployment to a production-like environment.
    - The main goal of Continuous Delivery is to ensure that the application is always in a deployable state, even after multiple changes by different developers. 
    - By automating these steps, Continuous Delivery eliminates the risk of human errors during the packaging process and reduces delays in getting the application ready for deployment. 
    - However, Continuous Delivery requires manual approval to release the application to the production environment. 
    - Although this gives teams greater control over when and how changes are deployed to live systems, Continuous Delivery is slower than Continuous Deployment because of this manual step.

3. What is continous deployment?
    - Continuous Deployment takes Continuous Delivery a step further by automating the actual deployment of the application to production. 
    - With this practice, every change that passes through automated tests and validations in the pipeline is automatically deployed to production without the need for manual intervention.
    - The strategy involves deploying to a staging environment first, where additional checks or validations might occur, and then promoting the changes to the live production environment. 
    - Unlike Continuous Delivery, Continuous Deployment eliminates the manual approval step, making it faster and more efficient. 
    - This approach ensures that updates, features, and fixes are delivered to customers as soon as they are ready, fostering rapid and iterative delivery. 
    - Continuous Deployment is ideal for teams that prioritize speed and frequent releases over manual control.

**Note**: 
    1. Automation is the key difference that sets Continuous Deployment apart from Continuous Delivery. 
    2. These two deployment types can be used together in a pipeline or adopted independently, depending on the organization’s processes and requirements. 
    3. When used together, the Continuous Delivery steps ensure the code is production-ready after passing all tests and reviews. 
    4. The Continuous Deployment then automates the final step of deploying production-ready code without manual intervention. 
    5. Using them together in a production environment provides an additional safety layer but also increases the time required.

## Command Line

1. What is .bashrc file?
    - it is primarily used to set confugurations of the terminal, like color, font etc.
    - It is essentially a script file that's executed when you first open the terminal window. 

2. What is the .profile file?
    - tends to be used more for environment variables. 
    - For example, we can use it for setting environment variables for my Java home directory or my Python home directory or whatever is needed during development. 

3. How do you let the operating system know that it is a bash script?
    - #!/bin/bash
    - we need to change the permission of the bash script to executable using chmod

4. What is a link directory?

5. What is drwxr marking on the left for a directory when it is listed with ls -l command?
    - it denotes that it is a standard directory

6. What is the association/symbol on the left for a text/configuration file when it is listed with ls -l command?
    - it is '-'

7. An any Linux command is that it takes an input and gives an output. What is the standard input and output device? 
    - The standard input device is the keyboard. 
    - The standard output device is the screen. 
    
8 . How can you cnhange th standard I/O? How many types of I/O or input output redirections exist?
    - With redirection, you can change the standard input and/or output. 
    - There are three types of IO or input/output redirections: Standard input, standard output, and standard error.

9. How does shell keep a reference of standard output, and error?
    - The shell keeps a reference of standard input, output, and error by a numbering system. 
    - The zero is for standard input, one is for standard output, and two is for standard error. 
    
10. What sign do we use for standard input?
    - < sign

11. What command can be used to record user input and save it to a file?
    -  cat > input.txt 
    -  enter the data, press enter for new lines
    -  cntrl+D to save the file
    - cat < input.txt will ouput the contents of the file.

12. What is sign for user standard output and standard error?
    - > sign for standard output
    - 2> sign for standard error

**Note**: Linux is a file-based system, and even the output of any command gets returned to a file.

13. By default where the does the output of any command like ls -l get sent?
    - to the stdout file.

14. How do we redirect the output of the command ls -l? 
    - ls -l ~/Documents > output.txt
    - the above command will store the ouput of ls -l ~/Documents to output.txt

15. How to redirect the error message if something goes wront while executing the command?
    - ls -l ~/Documents 2> error_output.txt
    - if the above command gives an error then the error is stored in error_output.txt.
    - but if the execution runs correctly then we see the output on screen and error_output.txt is empty. 
    - ls -l ~/Documents > output.txt 2>&1
    - if the above command gives an error then the error is stored in output.txt.
    - and if the execution runs correctly then the correct output is stored in  output.txt

16. What does GREP stand for?
    - Global regular expression print
    
  