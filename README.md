# Abap-for-Cloud-Development-CheatSheet
Original blog https://blogs.sap.com/2023/08/15/smooth-transition-to-abap-for-cloud-developmentcheat-sheet/

More and more organizations are coming across the term **ABAP on Cloud**. Whether they are considering **Side-by-Side Extension** with SAP Business Technology Platform or **On-stack Extension** in S4 HANA, I’m certain that this is discussed in your strategy meeting at least once.

ABAP on Cloud(aka **ABAP for Cloud Development** language version) is similar yet different from standard ABAP in many ways. Even if your organization holds in-house ABAP developers, the transition path to ABAP on Cloud may not be easy. This is due to the fact that certain APIs(table, function module, tcode, etc.) exist in your system built with standard ABAP language are not functional in ABAP on Cloud. On the front-end level, the major factor of not being able to use SAP GUI changes certain ABAP based solutions. In addition, there are changes in ABAP syntax as well.

This blogs is a **one-stop shop** for developers and IT strategist who like to make smooth transition from standard ABAP to ABAP for Cloud Development. It consists of three parts:

Cheat sheet on [LoB(Line of Business)](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/tree/main/line_of_business#readme) level
Cheat sheet on [Solution & Syntax](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/tree/main/solution_syntax) level
Solution overview & hint based on ABAP for Cloud Development
You can choose to just refer to the cheat sheet, or you can deep dive into each solution at later half of this blog.

<img width="589" alt="Diagram" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/c759b859-f00c-42ee-8a91-b2f9dd41e09c">

# Disclaimer
- Availability of ABAP object for cloud development may differ between ABAP Platform for S4 HANA and BTP ABAP Environment
- ABAP object for cloud development may be renewed and deprecated over time
- The list covers the most common ABAP topics and Line of Business(from personal perspective) but certain areas of your interest may be missing. You are welcome to comment these areas and I maybe able to add them later on.
# Contribution
Please refer to [CONTRIBUTING.md](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/CONTRIBUTING.md)
# Open points
ABAP Profiling
Debug background job class
