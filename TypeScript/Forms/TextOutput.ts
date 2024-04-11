import { getFormPath } from "Forms"

const TEXT_OUTPUT_FORM_FILE = "TextOutput.FRM"

interface frmTextOutput extends CheatEngine.Form {
    lblTitle: CheatEngine.Label
    memoContents: CheatEngine.Memo
}

export class TextOutput {
    private _form: frmTextOutput

    constructor(form: CheatEngine.Form | undefined = undefined) {
        this._form = form
            ? (form as frmTextOutput)
            : (createFormFromFile(getFormPath(TEXT_OUTPUT_FORM_FILE)) as frmTextOutput)
    }

    get form() {
        return this._form
    }

    set title(value: string) {
        this._form.caption = value
        this._form.lblTitle.caption = value
    }

    set contents(value: string) {
        this._form.memoContents.lines.text = value
    }

    clear() {
        this._form.memoContents.lines.clear()
    }

    append(value: string) {
        this._form.memoContents.append(value)
    }

    appendLine(value: string) {
        this._form.memoContents.append(`${value}\n`)
    }

    show() {
        this._form.show()
    }

    hide() {
        this._form.hide()
    }
}
