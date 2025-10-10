# Stripe Payment Demo: Automated AWS Deployment

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?logo=ansible&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?logo=nodedotjs&logoColor=white)
![Express.js](https://img.shields.io/badge/Express.js-000000?logo=express&logoColor=white)

This project is a simple Node.js application for Stripe payments. Its primary purpose is to demonstrate a fully automated deployment pipeline to the AWS cloud using modern DevOps tools. The entire process, from provisioning infrastructure to deploying the application, is managed through code.

---

### 🚀 Live Demo

You can view the live application here: **[http://107.22.16.112:3000/]**

> **Note:** This is a live demo running on an AWS EC2 instance. The environment may be decommissioned to manage costs, so the IP address can change. The automation scripts in this repository can be used to redeploy it at any time.

---

### 🛠️ Technology Stack

| Category                   | Technology                                      |
| -------------------------- | ----------------------------------------------- |
| **Cloud Provider** | AWS (EC2, VPC, Security Group, Elastic IP)      |
| **Infrastructure as Code** | Terraform                                       |
| **Configuration Management**| Ansible                                         |
| **Backend** | Node.js, Express.js                             |
| **Payments** | Stripe API                                      |
| **Process Manager** | PM2                                             |

---

### ⚙️ Automated Deployment Workflow

This project is deployed using Infrastructure as Code and Configuration Management. No manual clicking in the AWS Console is required.

#### Prerequisites
* Terraform installed
* Ansible installed
* AWS account and credentials configured locally

#### Deployment Steps

1.  **Provision the Infrastructure**
    From the project root, run Terraform to build the AWS server. This will create the EC2 instance, security group, and an elastic IP.
    ```bash
    terraform apply
    ```
    After it completes, Terraform will output the new `public_ip` for your server.

2.  **Configure Ansible**
    * Update the `inventory` file with the new IP address from the Terraform output and the path to your SSH private key.
    * Update the `vars` section in `playbook.yml` with your personal Stripe API keys.

3.  **Deploy the Application**
    Run the Ansible playbook to configure the server, install all dependencies, and launch the application.
    ```bash
    ansible-playbook -i inventory playbook.yml
    ```
    Your application is now live and managed by PM2.

---

### 💻 Running the Project Locally

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/Divyansh-77/Hosting-Node.js-App-on-AWS-EC2.git](https://github.com/Divyansh-77/Hosting-Node.js-App-on-AWS-EC2.git)
    cd Hosting-Node.js-App-on-AWS-EC2
    ```

2.  **Create a `.env` File**
    Create a `.env` file in the root directory with your Stripe API keys.
    ```
    PUBLISHABLE_KEY=pk_your_publishable_key
    SECRET_KEY=sk_your_secret_key
    ```

3.  **Install Dependencies and Start**
    ```bash
    npm install
    npm run start
    ```
    The application will be available at `http://localhost:3000`.
---
*Update: Testing the Jenkins CI/CD pipeline!*
*Triggering a new pipeline run.*
---

### 📚 Project Evolution: From Manual to Automated

This project initially began as a manual deployment to AWS to understand the fundamentals of cloud hosting. The original process involved manually configuring the EC2 instance in the AWS console, SSHing into the server, and running a series of shell commands to deploy the application.

To embrace DevOps best practices, the project was re-engineered. The manual steps have been entirely replaced with a fully automated workflow using **Terraform** for Infrastructure as Code and **Ansible** for Configuration Management. This transformation showcases the move from a traditional, error-prone process to a modern, reliable, and repeatable deployment pipeline.
