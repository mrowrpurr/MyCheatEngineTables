function setupMrowrPurrMenu() {
    const mainMenu = getMainForm().Menu
    const mrowrPurrMenu = createMenuItem(mainMenu)
    mrowrPurrMenu.caption = "Mrowr Purr"
    mainMenu.Items.add(mrowrPurrMenu)

    const testItem = createMenuItem(mrowrPurrMenu)
    testItem.caption = "Test"
    testItem.setOnClick(() => {
        showMessage("Test clicked!")
    })
    testItem.setShortcut("Ctrl+Shift+T")
    mrowrPurrMenu.add(testItem)
}

export function autorun() {
    setupMrowrPurrMenu()
}
