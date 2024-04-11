export function getFormPath(formPath: string) {
    const rootFormsPath = os.getenv("CE_FORMS_PATH")
    return rootFormsPath ? `${rootFormsPath}/${formPath}` : formPath
}
