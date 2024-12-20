Config = {}

Config.Framework = "qbox/qb" -- qbox/qb or esx

Config.Items = {
    ["testburger"] = { -- test item
        propModel = "prop_cs_cardbox_01",
        requiredCount = 1, -- if count will be equal or more than this, then the prop will appear.
        offset = vec3(0.0, 0.0, 0.2),
        pos = vec3(0.2, 0.08, 0.2), -- nil for default settings
        rot = vec3(-45.0, 290.0, 0.0) -- nil for default settings
    }
}