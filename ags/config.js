import { Bar } from "./system_bar.js"
import { APP_LAUNCHER } from "./app_launcher.js"
import { NotificationPopups } from "./notifications_popups.js"

App.config({
    style: "./style.css",
    windows: [
        Bar(),
        APP_LAUNCHER,
        NotificationPopups(),
    ],
})
