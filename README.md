# 🔐 RealPlay-Scripts License Manager

## Description

**RealPlay-Scripts License Manager** is a powerful and easy-to-use FiveM script designed for the **QBCore** or **Qbox** Framework. It provides law enforcement officers, specific job roles, and administrators the ability to manage player licenses directly via a modern UI interface and intuitive command system.

Whether you're running a roleplay server or a law enforcement-focused community, this tool makes managing licenses simple and efficient—with full support for job- and license-specific permission levels.

---

## 🚀 Key Features

- ✅ **Grant and Revoke Licenses**  
  Use the interactive UI or simple commands to manage licenses like `driver`, `weapon`, `hunting`, and more.

- 🔐 **Configurable Permissions**  
  Job-based license permissions are fully controlled through `config.lua`, allowing you to define which jobs and grades can grant/revoke specific licenses.

- 👮‍♂️ **Admin Override**  
  Admins automatically have full access to manage any license, bypassing job restrictions.

- 🧠 **Smart UI Access**  
  The `/managelicense` command checks job, grade, and permissions from the config before opening the NUI interface.

- 💾 **Database Integration**  
  License changes are saved to the database and reflected in real-time using metadata updates.

- 🔔 **Clean Notifications**  
  Leverages `ox_lib` to send professional, non-intrusive alerts and messages.

- 🛠️ **Customizable License Types**  
  Driver, Weapon, Hunting, and more—fully customizable via `config.lua` to match your server's needs.

- 🔄 **Radial Menu Integration**  
  Optional radial menu access to the License Manager UI for roleplay immersion.

---

## 🧩 How It Works

1. Players with the correct **job/grade** (defined in config) or those in the **admin group** use the `/managelicense` command or radial menu.
2. The NUI UI opens, letting them:
   - Enter **Player ID**
   - Select **License Type**
   - Choose **Action** (Grant or Revoke)
3. Data is sent to the server which:
   - Checks config-defined permissions for that license
   - Applies the action to the target player
   - Updates metadata and saves to the database
4. Both users receive confirmation via `ox_lib` notifications.

---


🔄 Scrips Documentation

- [Documentation](https://realplay-scripts-1.gitbook.io/realplay-scripts-documentation/free-scripts/rps-licensemanager-nui) 

