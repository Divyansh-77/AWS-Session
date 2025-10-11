# 🚀 Automated CI/CD Pipeline for a Node.js App on AWS

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white" alt="Ansible" />
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions" />
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white" alt="Node.js" />
</p>

<p align="center">
  <img src="https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/deploy.yml/badge.svg" alt="CI/CD Status" />
</p>

---

## 🎯 Project Goal

The goal was to transform a manual deployment process for a Node.js application into a **fully automated CI/CD pipeline**. Now, every `git push` to the `main` branch automatically builds, tests, and deploys the application to an AWS EC2 instance with **zero manual intervention**.

This project showcases a real-world DevOps workflow, demonstrating skills in Infrastructure as Code (IaC), Configuration Management, and CI/CD automation.

---

## 🏗️ Architecture & Workflow

The entire process is split into two phases: a one-time setup and the automated deployment cycle.

> **Analogy:** Think of it like setting up a new restaurant.
>
> 1.  **Phase 1 (Infrastructure):** You first build the kitchen (**Terraform creates the AWS EC2 server**) and then install all the equipment like ovens and stoves (**Ansible configures the server with Node.js, PM2, etc.**). This is a one-time job.
> 2.  **Phase 2 (Automation):** Now, you hire a robotic chef (**GitHub Actions**). Every time a new recipe (`git push`) is finalized, the robot automatically cooks and serves it in the kitchen, without you needing to do anything.



---

## 🛠️ Tech Stack

| Tool             | Purpose                                   |
| ---------------- | ----------------------------------------- |
| **AWS EC2** | To host the Node.js web application.      |
| **Terraform** | **Infrastructure as Code (IaC)** to provision the server. |
| **Ansible** | **Configuration Management** to set up the server. |
| **GitHub Actions** | **CI/CD** to automate the deployment workflow. |
| **Node.js** | Application runtime environment.          |
| **PM2** | Process manager for Node.js to ensure zero downtime. |

---

## 🚀 How to Run This Project

### Prerequisites
* An **AWS Account** with an IAM User (programmatic access).
* **Terraform** installed on your local machine.
* **Ansible** installed on your local machine.

### Part 1: One-Time Infrastructure & Server Setup

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/YOUR_REPO.git](https://github.com/YOUR_USERNAME/YOUR_REPO.git)
    cd YOUR_REPO
    ```

2.  **Provision the Infrastructure with Terraform**
    Navigate to the Terraform directory and run the commands. This will create the EC2 instance, security group, and an SSH key pair.
    ```bash
    cd terraform
    terraform init
    terraform apply --auto-approve
    ```
    ✅ **Result:** Terraform will output the `public_ip` of your new EC2 server. An SSH key named `automated-deployment-tf.pem` will be created in this directory.

3.  **Configure the Server with Ansible**
    First, update the `ansible/inventory` file with the public IP from the previous step. Then, run the Ansible playbook.
    ```bash
    # Go back to the root directory
    cd ..

    # Run the playbook to install Node.js, PM2, and deploy the app for the first time
    ansible-playbook ansible/playbook.yml \
      -i ansible/inventory \
      -u ubuntu \
      --private-key=terraform/automated-deployment-tf.pem
    ```
    🎉 **Success!** Your Node.js application is now live. You can access it at `http://<YOUR_EC2_PUBLIC_IP>:3000`.

### Part 2: Automating Deployments with GitHub Actions

**1. Add GitHub Secrets**

To allow GitHub Actions to securely access your server and use application credentials without hard-coding them, add the following secrets to your repository (`Settings` > `Secrets and variables` > `Actions`).

This single, secure location is used for **both infrastructure credentials** (like the SSH key) **and application-level API keys** (like Stripe).

| Name | Value |
| :--- | :--- |
| `EC2_HOST_IP` | Your EC2 instance's public IP address. |
| `EC2_USERNAME` | `ubuntu` (for Ubuntu EC2 instances). |
| `EC2_SSH_KEY` | The **entire content** of the `.pem` file. |
| `STRIPE_SECRET_KEY` | Your Stripe secret key (e.g., `sk_test_...`). |
| `STRIPE_PUBLIC_KEY` | Your Stripe publishable key (e.g., `pk_test_...`). |

**2. Trigger the CI/CD Pipeline**

The workflow file `.github/workflows/deploy.yml` is already set up. Simply make a change to your code and push it to the `main` branch.
```bash
git add .
git commit -m "Testing my new automated pipeline!"
git push origin main

📂 Repository Structure
.
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions workflow for CI/CD
├── ansible/
│   ├── inventory           # Holds the server IP for Ansible
│   └── playbook.yml        # Ansible playbook to configure the server
├── app/
│   ├── .env                # Stores local environment variables (MUST be in .gitignore)
│   ├── index.js            # Sample Node.js application
│   └── package.json
├── terraform/
│   ├── main.tf             # Main Terraform script for creating AWS resources
│   ├── outputs.tf
│   └── variables.tf
├── .gitignore              # Specifies files to be ignored by Git
└── README.md
