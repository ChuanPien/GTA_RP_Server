Config = {}

Config.Locale = 'en'
 Config.Prices = {
    Nothing = {
        50, -- chance
        0, -- price
        '~c~Sadly, you didn\'t win anything, you win some, you lose some.~s~'
        },
    Common = {
        25, -- chance
        100, -- price
        '~g~You won $100!~s~ Not too bad!'
        },
    Rare = {
        15, -- chance
        250, -- price
        '~g~You won!~s~ Buy yourself something nice worth ~g~$250~s~!'
        },
    Epic = {
        9, -- chance
        750, -- price
        '~g~You won big time! ~g~+ $750~s~!'
        },
    Legendary = {
        1, -- chance
        1000, -- price
        '~r~L~b~E~g~G~y~E~p~N~q~D~o~A~r~R~b~Y~s~! You won ~g~$1000~s~!'
        }
}
