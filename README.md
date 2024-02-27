## Abstract
Configuration files for creating a sample containerized environment for a Rails API application

## Request

We must separate all software requirements from the local system while also sharing a folder with the application between the virtual and local systems. 

Additionally, the application should run with non-root privileges inside its container.

## Details 

Perhaps it would be better to make one image, but there are already redy to use compact ones. Custom image tends to bloat significantly.  Also, in a production database separated from an application; it would be not bad to mimic this in development. 

## To Be Implemented

1. Versions are not pinned neither for gems nor for pacages in the 'web'.
2. IDE integration

