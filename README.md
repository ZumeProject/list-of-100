# Zume List of 100

A small application supporting the list of 100 activity.

Web version: <https://listof100.zume.training/>

## Overview

This application helps users create and manage their "List of 100" - a list of people in their life and identify if they are a Believer, Unbeliever, or Unknown. Key features include:

- Create multiple lists with different themes/categories
- Add, edit and delete items in your lists
- Track progress with item count and completion status
- Persistent storage so your lists are saved locally
- Clean, minimalist interface focused on the writing experience
- Works offline as a Progressive Web App (PWA)
- Mobile-friendly responsive design

The web version is built with Flutter and can be accessed at <https://listof100.zume.training/>

## Build web and deploy

```bash
flutter build web
ghp-import -n -p -f build/web
```
