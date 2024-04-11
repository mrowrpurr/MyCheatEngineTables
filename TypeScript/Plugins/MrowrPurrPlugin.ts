import { showRegistersWindow } from "Debugging/ShowRegisters"
import { showStackWindow } from "Debugging/ShowTopOfStack"

function setupMrowrPurrMenu() {
    //
    const mainMenu = getMainForm().Menu
    const mrowrPurrMenu = createMenuItem(mainMenu)
    mrowrPurrMenu.caption = "Mrowr Purr"
    mainMenu.Items.add(mrowrPurrMenu)

    //
    const showRegistersItem = createMenuItem(mrowrPurrMenu)
    showRegistersItem.caption = "Registers Window"
    showRegistersItem.setOnClick(() => {
        showRegistersWindow()
    })
    showRegistersItem.setShortcut("Ctrl+Alt+E")
    mrowrPurrMenu.add(showRegistersItem)

    //
    const showStackItem = createMenuItem(mrowrPurrMenu)
    showStackItem.caption = "Stack Window"
    showStackItem.setOnClick(() => {
        showStackWindow()
    })
    showStackItem.setShortcut("Ctrl+Alt+C")
    mrowrPurrMenu.add(showStackItem)
}

export function autorun() {
    setupMrowrPurrMenu()
}
