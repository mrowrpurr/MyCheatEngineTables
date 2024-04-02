class Script1 {
  constructor() {
    print("Hello! I'm Script1 constructor")
  }

  enable() {
    print("Hello! I'm Script1 enable")
  }

  disable() {
    print("Hello! I'm Script1 disable")
  }
}

const script = new Script1()

export function enable() {
  script.enable()
}

export function disable() {
  script.disable()
}
