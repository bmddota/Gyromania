function test4(keys)
  local damageTable = {
    victim = keys.target,
    attacker = keys.caster,
    damage = 200,
    damage_type = DAMAGE_TYPE_PURE,
  }
  ApplyDamage(damageTable)
end