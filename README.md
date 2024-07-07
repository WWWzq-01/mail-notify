# mail-notify
A tool for sending email notifications to users when a long-running program finishes.

<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites
- mail
- ssmtp

refer to [ubuntu email smtp](https://blog.csdn.net/u010953692/article/details/121744436)
### Installation
1. Clone the repository
2. Create a symbolic link
```
sudo bash install_shell.sh
```
3. Reload the shell
```
source ~/.bashrc
```
### Usage
`notify [command] [address]`
- If [address] is not given, the default value is used.