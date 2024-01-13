HTCondor NFS Setup and DAG Execution Guide
==========================================

This guide provides instructions for setting up NFS mounting in an HTCondor environment and running DAG jobs. The process involves configuring the UID domain, properly setting up NFS mounts, and executing a DAG file.

Prerequisites
-------------

-   Ubuntu server(s) for NFS server and clients.
-   HTCondor installed on all relevant machines.
-   Sudo privileges on all machines.

Configuration Steps
-------------------

### Step 1: Set Up UID Domain

The UID domain ensures that user IDs (UIDs) are consistent across different machines in the HTCondor pool.

1.  Edit HTCondor Config:

    -   Open the HTCondor configuration file (usually found at `/etc/condor/condor_config`).
    -   Add or modify the `UID_DOMAIN` setting to match your domain. For example:

        makefileCopy code

        `UID_DOMAIN = ec2.internal`

    -   Save and close the file.
2.  Restart HTCondor:

    -   Restart the HTCondor service to apply the changes:

        bashCopy code

        `sudo systemctl restart condor`

### Step 2: Mount NFS Share

Set up the NFS share on the server and mount it on the client machines.

#### On the NFS Server:

1.  Install NFS Kernel Server:

    -   Install the NFS kernel server package:

        bashCopy code

        `sudo apt-get install nfs-kernel-server`

2.  Configure Exports:

    -   Edit `/etc/exports` to share the desired directory. For example:

        bashCopy code

        `/home/ubuntu/sentiment <client-IP>(rw,sync,no_subtree_check,anonuid=1000,anongid=1000)`

    -   Replace `<client-IP>` with the IP address or range of your HTCondor client machines. Here 1000 is default user id. 
3.  Export the Shared Directory:

    -   Run the following command to apply the export settings:

        bashCopy code

        `sudo exportfs -ra`

4.  Start NFS Server:

    -   Ensure that the NFS server is running:

        bashCopy code

        `sudo systemctl start nfs-kernel-server`

#### On the NFS Client(s):

1.  Install NFS Client:

    -   Install NFS client utilities:

        bashCopy code

        `sudo apt-get install nfs-common`

2.  Create Mount Point:

    -   Create a directory to serve as the mount point:

        bashCopy code

        `sudo mkdir -p /home/ubuntu/sentiment`

3.  Mount the NFS Share:

    -   Mount the NFS share from the server:

        bashCopy code

        `sudo mount -t nfs <server-IP>:/home/ubuntu/sentiment /home/ubuntu/sentiment`

    -   Replace `<server-IP>` with the IP address of your NFS server.

### Step 3: Running the DAG File

After setting up NFS mounts, you can run DAG jobs in HTCondor.

1.  Create a DAG File:

    -   Create a DAG file (e.g., `example.dag`) defining your job dependencies.
2.  Submit the DAG Job:

    -   Use the `condor_submit_dag` command to submit the DAG job:

        bashCopy code

        `condor_submit_dag example.dag`

3.  Monitor the Job:

    -   Use `condor_q` to monitor the status of your DAG job.

Conclusion
----------

Following these steps should allow you to set up NFS mounts in an HTCondor environment and execute DAG jobs effectively. Ensure that all configurations are properly set up and consistent across all machines for optimal performance.
