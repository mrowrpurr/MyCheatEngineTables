const TEXT_OUTPUT_FORM_FILE = "Forms/TextOutput.FRM"

interface frmTextOutput extends CheatEngine.Form {
    lblTitle: CheatEngine.Label
    lblContents: CheatEngine.Label
}

export class TextOutput {
    private _form: frmTextOutput

    constructor(defaultTitle: string | undefined = undefined) {
        print(`Creating form from file ${TEXT_OUTPUT_FORM_FILE}`)
        const form = createFormFromFile(TEXT_OUTPUT_FORM_FILE)
        if (form === undefined) {
            print(`Error: Could not create form from file ${TEXT_OUTPUT_FORM_FILE}`)
            this._form = {} as frmTextOutput
        } else {
            this._form = form as frmTextOutput
            print("Form created successfully")
        }
        // this._form = <frmTextOutput>createFormFromFile(TEXT_OUTPUT_FORM_FILE)
        if (defaultTitle !== undefined) this.title = defaultTitle
        print(".....")
    }

    set title(value: string) {
        this._form.caption = value
        this._form.lblTitle.caption = value
    }

    set contents(value: string) {
        this._form.lblContents.caption = value
    }

    clear() {
        this._form.lblContents.caption = ""
    }

    append(value: string) {
        this._form.lblContents.caption += value
    }

    appendLine(value: string) {
        this._form.lblContents.caption += `${value}\n`
    }

    show() {
        this._form.show()
    }

    hide() {
        this._form.hide()
    }

    onClose(callback: any) {
        print("SKIPPING onClose")
        // print("Setting onClose...")
        // this._form.onClose(callback)
        // print("onClose set")
    }
}
