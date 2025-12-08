---
title: "Mini-post: Mini SIGINT Adventure"
pubDate: "2025-01-27"
tags:
  [
    "nmap", "remote desktop", "ping"
  ]
draft: false
description: How I connect to my headless server at my new place
heroImage: "/blog-content/mini-sigint-adventure.png"
---

After much introspection and a relatively long-winded process, I have finally moved to a new place. Albeit I am currently paying double rent for the next 5 months, I am now living and enjoying life more comfortably. I cook more and take public transits more so it's a healthier lifestyle. Anything to get away from the noisy neighbours issue and the depressing basement atmosphere.

This week, my second week after finishing moving, I started to settle in, unpacking a little bit and organizing things more neatly. Plus, I'm Marie Kondo-ing a lot of stuff to free up space. I just finished setting up my server and luckily for me, it was pretty a plug-n-play endeavor, with some spices -- which I shall indulge in recounting the steps now.

New place means new network. Not only am I forgoing my highest-tier home internet for a lower speed network, I am also letting go of the full control over the home internet, which means that I can't just plug in stuff directly into the modem/router without having to route a long ethernet cable. To keep the hall clear of additional cables, I only run 1 to my desktop. Until today. I bought a cheap TP-LINK TL-SG105 (god help me with Chinese spyware) network switch for $22 before tax and a new generic 20 ft. (6 m) CAT 6 ethernet cable at Canada Computers after school. I plugged the everything in (modem/router to switch, switch to desktop PC and server) and everything seemed to be working perfectly, a la _having internet connection_ and _blinking lights_.

Now, the biggest obvious problem to me is that, "how the hell do I connect to my headless server?" I certainly do not want to plug in a monitor nor keyboard and mouse nor set up the video capture card because that is too much work after a long ass day. Since the hardware solutions are not in the realm of possibility, I resorted to software. To connect to a machine I need to know 2 key information:

- IP address
- Operating System
  - windows ? rdp : linux ? ssh : tomorrow Anh's problem

> How do you get the IP address when you're blinded in the network?

There's a neat little tool called `nmap`, website pictured in the screenshot above. I installed the GUI version, Zenmap, on my Windows desktop and went in straight for the ping scan. The nmap scan command targets IP addresses in the 10.0.0.0/24 range which goes from `10.0.0.1` to `10.0.0.254` as the usable host range. A ping scan gives minimal information but very quick. But it is sometimes enough to extrapolate some information about the host at its IP(v4 in this case) address. That piece of information is the TTL, or Time To Live, number. As the greatest ex-IT specialist that has ever lived, I have memorized some important TTL numbers at the back of my head because the TTL number may indicate which operating system the host may be running. For Linux and macOS, it's usually 64; for Windows, usually 128.

Although the ping scan results are helpful and I was able to identify some hosts, among which were my desktop returning TTL=128 and another one with 128. But I wasn't sure because my flatmate also has a Windows PC. And the results didn't indicate the FQDN of that suspect host, which should by my server hostname, because I am smart so I always set my devices' hostname systematically. My next choice is a quick scan, which I honestly do not know what checks it does under the hood but god damn it was fast. And finally, it confirmed my suspicion that the other device with TTL=128 was my server after all.

Knowing that my server is running Windows, I just simply remote desktop into it with my Microsoft account credentials and I was in. After which, I verified internet connectivity that it was all in order.

And they live happily ever after.

P.S. The reason why I set up my headless server is to have a low-powered juice-sipping-slowly host to remote into whenever I'm outside, given that now I'm outside more frequently. This remote requirement is achieved easily through Tailscale. Aaaand I just swallowed half a red pill by watching https://www.youtube.com/watch?v=KQ2gz5i7VAA last night at 2am in the morning. And most importantly, I can now YEEAAAATTT my $12/mo. Linode to save some money.