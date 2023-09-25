### Installing SSL Certificate on domain with OpenSSL's Let's Encrypt for Apache configured VPS

Firstly, ensure that you are able to SSH into your VPS as root. Then ensure that certbot isn't install in the system

Uninstall any system-default certbot by running either one of this command `sudo apt-get remove certbot`, `sudo dnf remove certbot`, or `sudo yum remove certbot`

Then install certbot by running in sequence `sudo apt-get update` and `sudo apt-get install certbot`

If you have a firewall, which is very advised, run `sudo ufw allow 80` to allow HTTP's port 80 for the certificate to use

To actually create the certificate, you'd need to run some commands:

`sudo certbot certonly --standalone --preferred-challenges http -d YOUR_EXAMPLE_DOMAIN`

After having ran that command, run this one `sudo ls /etc/letsencrypt/live/YOUR_EXAMPLE_DOMAIN` and if the result is similar to the one below, you are almost done
```bash
Output
cert.pem  chain.pem  fullchain.pem  privkey.pem  README
```

Now, for installing the SSL Certificate into Apache run those commands

`sudo certbot --apache`

`sudo certbot --apache -d YOUR_EXAMPLE_DOMAIN -d www.YOUR_EXAMPLE_DOMAIN`

Then, follow those steps

Enter an email address for renewal and security notices.

Agree to the terms of service.

Specify whether to receive emails from EFF.

If prompted, choose whether to redirect HTTP traffic to HTTPS – 1 (no redirect, no further changes to the server) or 2 (redirect all HTTP requests to HTTPS).

#### Renewal, troubleshooting or errors

In case certbot may prompt an error, or the cerbot apache configurations fails, you'd probably need to install some missing packages. Try running those commands:

```bash
sudo apt install snapd # Install snapd
sudo snap install core; sudo snap refresh core # Ensure you have the latest snapd version installed
sudo snap install --classic certbot # Install Certbot with snapd
sudo ln -s /snap/bin/certbot /usr/bin/certbot # Create a symlink to ensure Certbot runs
```

Now try redoing the apache configuration process above

In case this fails, try updating apache's python certbot pkg by running `sudo apt-get install python-certbot-apache`

Try again the above procedure

Please ensure that all DNS records do point at the correct host via the correct protocols and mask (CNAME, A, Etc)

Having an address (www.dns.yourdomain.com) without a correct DNS record will make the SSL verification fail. Either attach the configuration to your registar or avoid configuring the SSL for such domain


If you have followed all steps successfully you should have a site with an SSL certificate running

Sources:
 - https://www.digitalocean.com/community/tutorials/how-to-use-certbot-standalone-mode-to-retrieve-let-s-encrypt-ssl-certificates-on-ubuntu-16-04
 - https://certbot.eff.org/hosting_providers
 - https://certbot.eff.org/instructions?ws=apache&os=ubuntufocal&tab=wildcard
 - https://eff-certbot.readthedocs.io/en/stable/using.html#manual
 - https://www.inmotionhosting.com/support/website/ssl/lets-encrypt-ssl-ubuntu-with-certbot/#snapd