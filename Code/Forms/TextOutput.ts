const TEXT_OUTPUT_FORM_FILE = "Forms/TextOutput.FRM"

interface frmTextOutput extends CheatEngine.Form {
    lblTitle: CheatEngine.Label
    lblContents: CheatEngine.Label
}

export class TextOutput {
    private _form: frmTextOutput

    constructor(form: CheatEngine.Form | undefined = undefined) {
        this._form = form
            ? (form as frmTextOutput)
            : (createFormFromFile(TEXT_OUTPUT_FORM_FILE) as frmTextOutput)
    }

    get form() {
        return this._form
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
}
