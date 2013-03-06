root = exports ? this

class ObjectHelper
  @addRole: (base, role) =>
    if not role::augment?
      throw "RoleMustHave.augment()"
    role::augment(base)
    _.bindAll(base)

root.ObjectHelper = ObjectHelper
