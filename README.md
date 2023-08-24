# abap-for-cloud-development-cheatsheet
Cheatsheet for smooth adaptation to ABAP on Cloud
Original blog https://blogs.sap.com/2023/08/15/smooth-transition-to-abap-for-cloud-developmentcheat-sheet/

More and more organizations are coming across the term **ABAP on Cloud**. Whether they are considering **Side-by-Side Extension** with SAP Business Technology Platform or **On-stack Extension** in S4 HANA, I’m certain that this is discussed in your strategy meeting at least once.

ABAP on Cloud(aka **ABAP for Cloud Development** language version) is similar yet different from standard ABAP in many ways. Even if your organization holds in-house ABAP developers, the transition path to ABAP on Cloud may not be easy. This is due to the fact that certain APIs(table, function module, tcode, etc.) exist in your system built with standard ABAP language are not functional in ABAP on Cloud. On the front-end level, the major factor of not being able to use SAP GUI changes certain ABAP based solutions. In addition, there are changes in ABAP syntax as well.

This blogs is a **one-stop shop** for developers and IT strategist who like to make smooth transition from standard ABAP to ABAP for Cloud Development. It consists of three parts:

Cheat sheet on [LoB(Line of Business)](../line_of_business/master/README.md) level
Cheat sheet on **Solution & Syntax**(https://www.google.com) level
Solution overview & hint based on ABAP for Cloud Development
You can choose to just refer to the cheat sheet, or you can deep dive into each solution at later half of this blog.

<img width="589" alt="Diagram" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/0b32801b-0f02-4acd-bc65-d83f8a4b40b0">

# Disclaimer
- Availability of ABAP object for cloud development may differ between ABAP Platform for S4 HANA and BTP ABAP Environment
- ABAP object for cloud development may be renewed and deprecated over time
- The list covers the most common ABAP topics and Line of Business(from personal perspective) but certain areas of your interest may be missing. You are welcome to comment these areas and I maybe able to add them later on.
