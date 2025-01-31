
## IMPORTANT: This repo is not approved for sharing with customers, or any other exposure outside of Grafana Labs.
It has no license attached. 

Do not share!

(For the moment, this is only meant for sharing some ideas around the OA team).

<br>

# deploy-otel-demo-alloy
This project helps you accelerate the process of standing up the [OpenTelemetry Demo](https://opentelemetry.io/docs/demo/architecture/) and Grafana Alloy, with Alloy shipping your OTel telemetry to your Grafana Cloud account.

<br>

## Video Walkthrough
For a quick intro to this repo, try [watching this video](https://drive.google.com/file/d/1ptZXiM8xO8fh16wI8VjqDNeqAqljWsM2/view?usp=sharing).

<br>

## Quick setup steps

These steps are very brief by design. They will assume that you have solid background in a number of areas. Further areas of the documentation will help users learn each step in more detail.

Note that these are written for the Linux OS; we do not yet document how to run this on other operating systems.

<br>

### Prerequisites
K8s cluster:   I recommend at least the equivalent of [4 e2-medium machines](https://cloud.google.com/compute/docs/general-purpose-machines#e2-shared-core). 

CLIs:          Git, Kubectl, Flux

Viewer:        K9s, or whatever solution you like

Code:          VSCode, or whatever solution you like

<br>

### Fork, then clone, this repo
Cloning without forking won't work. Make your own fork, then clone your fork to your machine. Then cd into the top level directory.

> (For the moment, there is a [parallel version of this repo](https://github.com/danstadler-pdx/deploy-otel-demo-alloy), that you can fork. We are working on an improvement for this step, that we will share shortly.)



<br>

### Create a file like this, and make sure you don't commit it into source code management
```
export GITHUB_USER=
export GITHUB_TOKEN=
export ALLOY_CLOUD_OTLP_URL=
export ALLOY_CLOUD_OTLP_USERNAME=
export ALLOY_CLOUD_OTLP_PASSSWORD_BASE64=
```

<br>

### Fill in the values for those fields
First 2: Fill in your GH username, and go get a "classic personal access token" from GH with all Repo permissions enabled; no other permissions needed.

Last 3:  From your Grafana Cloud Portal, go into a stack, then into the OpenTelemetry section, and get your username, url, and auth token.

### IMPORTANT: base64 encode your token
Before putting the Grafana Cloud OTel auth token into its place in the above exports, base64 encode it.

<br>

### Run the 5 exports
Your choice:
- make the file executable and run it;
- copy/paste the export statements to the command line;
- make them part of your environment setup in another way of your choosing.

<br>

### Now run the project
You should now be good to run the following 2 commands, from the root directory of the project.

```
./pre-provision/pre-provision.sh
```

```
CURRENT=`pwd`; BASENAME=`basename "$CURRENT"`; \
flux bootstrap github \
    --context=$(kubectl config current-context) \
    --owner=${GITHUB_USER} \
    --repository=${BASENAME} \
    --branch=main \
    --path=clusters/staging
```

<br>

## Sanity Check
Use k9s or the viewer of your choice, to see that Alloy comes up in the "collector" namespace, and the OTel Demo comes up in the "open-telemetry" namespace.

Go to your cloud account, and use the Explore Logs UI to see that logs are arriving from a number of the services in the OTel Demo.




<br>
<br>

# Getting Started

Please see the "how-to-run.md" page (in zzz_documentation) for more detailed instructions on running this project.

<br>

# Further Learning

Please see the "overview.md" page (in zzz_documentation) for more detail on the overall project.

