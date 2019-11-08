Before start:

The text inside triangular brackets (i.e. <>) represents something that needs to be changed to YOUR OWN value, and the brackets themselves need to be deleted. For example, <your-favorite-season> has to be changed to summer (if your favorite season is summer).

Uploading MyCollab project to Gitlab.

1. Go to https://gitlab.com/

2. Click on "Register" on the right top of the page (and follow all of the steps until you are signed in) or click on "Sign in" if you already have an account.

3. Click on "New project" on the right top of the page.

4. Type in any name of the project in the "Project name" field and click on "Create project".

5. Click on "Clone" on the right top of the page and copy the link under "Clone with SSH" line.

6. Start up the terminal on your machine and change the working directory to the one that contains the files of MyCollab project:
git init
git remote add origin <link-from-previous-step>
git add .
git commit -m "<commit-message>"
git push -u origin master

Deploying database to AWS.

1. Go to https://console.aws.amazon.com/

2. Click on "Create a new AWS account" (and follow all of the steps until you are signed in) or sign in with your existing account.

3. After signing in you should be redirected to https://us-east-2.console.aws.amazon.com/console/home?region=us-east-2# (if not, please follow the link by yourself)

4. Click on "Services" on the left top of the page.

5. Click on "EC2"

6. Click on "Launch instance" on the left center of the page.

7. Find "Amazon Linux 2 AMI (HVM), SSD Volume Type" on the list (radio button "64-bit (x86)" should be selected) and click on corresponding "Select" button.

8. On the top of the page click on "6. Configure Security Group".

9. Click on "Add rule"

10. On the newly appeared rule select Type "MYSQL/Aurora" and Source "Anywhere" and click on "Review and Launch"

11. Make sure that you have 3 rules under section "Security groups": "SSH" and two "MYSQL/Aurora" (If you don't, go back to the step 8) and click on "Launch".

12. In the first field select "Create a new key pair", in the Key pair name type in "database", click on "Download Key Pair" and save the file on your machine.

13. And finally click on "Launch Instances"

14. Click on "Services" on the left top of the page and then on "EC2" again.

15. Click on "Instances" on the left side of the page.

16. Check that you have a running instance ("Instance State" should be "running") and click on it.

17. Click "Connect" on the top of the page.

18. Don't close the tab in your browser, start up the terminal on your machine and change the working directory to the one that contains the dowloaded "database.pem" file.

19. Execute:
chmod 400 database.pem

20. Come back to the tab in your browser and find the line below the "Example:", it should be similar to:
ssh -i "database.pem" ec2-user@<name-of-instance>.us-east-2.compute.amazonaws.com

21. Copy the line from your browser and execute it in the terminal (directory should be the one with "database.pem")

22. Type "yes" if you are asked:
Are you sure you want to continue connecting (yes/no)?

23. Congratulations! You are now connected to EC2 instance from your local machine!

24. Execute following lines one by one:
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo yum localinstall mysql80-community-release-el7-3.noarch.rpm -y
sudo yum install mysql-community-server -y
sudo service mysqld start
sudo grep "temporary password" /var/log/mysqld.log

25. After the execution of the last line you should get something similar:
[Note] [MY-010454] [Server] A temporary password is generated for root@localhost: <your-password>
Copy the temporary password from the last line!

26. Execute:
sudo mysql_secure_installation
And when you are asked:
Enter password for user root: 
Insert the temporary root password that you copied on the last step and press Enter.

27. When you are asked:
New password: 
Type in new password (Warning: it should be a complex one, upper and lower case letters, numbers and some symbols)
When asked:
Re-enter new password:
Type in your new password again.

28. When asked:
Change the password for root ? ((Press y|Y for Yes, any other key for No) :
Type in 'y'.

29. Type in your password again when asked:
New password:
and 
Re-enter new password:
Don't forget it! It will be your password for root user!

30. When asked:
Remove anonymous users? (Press y|Y for Yes, any other key for No) :
Type in 'n'.
When asked:
Disallow root login remotely? (Press y|Y for Yes, any other key for No) :
Type in 'n'.
When asked:
Remove test database and access to it? (Press y|Y for Yes, any other key for No) :
Type in 'y'.
When asked:
Reload privilege tables now? (Press y|Y for Yes, any other key for No) :
Type in 'y'.

31. Execute:
mysql -u root -p
and when asked:
Enter password: 
Type in your password for root user.

32. Execute following lines one by one:
CREATE USER 'root'@'%' IDENTIFIED BY '<your-password>';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE DATABASE mycollab;
SET GLOBAL time_zone = '+3:00';
exit;
sudo service mysqld restart

Congratulations!!! You have deployed your own MySQL database on AWS EC2 instance.
