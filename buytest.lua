-- 🐢 SLOW INJECTOR v2.0
-- تغيير Token/Tokens إلى 999999 بطريقة متخفية
-- ⚠️ للبيئات الآمنة فقط!

local plr = game.Players.LocalPlayer
local TARGET_VALUE = 999999
local injectionLog = {}

-- 🎭 تقنيات التخفي
local StealthTechniques = {
    RANDOM_DELAYS = true,      -- فترات انتظار عشوائية
    HUMAN_PATTERNS = true,     -- أنماط بشرية
    PARTIAL_MODIFICATION = true,-- تعديل جزئي فقط
    FAKE_ACTIVITY = true       -- نشاط وهمي
}

-- 🔍 البحث الذكي (بطيء ومتخفي)
local function stealthFindTokens()
    print("🔍 [STEALTH] البحث المتخفي عن Tokens...")
    
    local found = {}
    local searchAreas = {
        game.Workspace,
        game:GetService("ReplicatedStorage"),
        game:GetService("ServerStorage"),
        game:GetService("Lighting"),
        plr
    }
    
    -- بحث بطيء مع استراحات
    for areaIndex, area in pairs(searchAreas) do
        if StealthTechniques.FAKE_ACTIVITY then
            -- نشاط وهمي (يشتت النظام)
            local fakeGui = Instance.new("ScreenGui")
            fakeGui.Name = "FakeUI_" .. math.random(1000)
            fakeGui.ResetOnSpawn = false
            fakeGui.Parent = plr.PlayerGui
            task.wait(0.1)
            fakeGui:Destroy()
        end
        
        -- مسح بطيء للمنطقة
        local descendants = area:GetDescendants()
        for i, obj in pairs(descendants) do
            -- فحص بطيء
            if obj.Name:lower():find("token") then
                table.insert(found, {
                    object = obj,
                    path = obj:GetFullName(),
                    original = obj.Value,
                    type = obj.ClassName
                })
                
                -- استراحة عشوائية
                if StealthTechniques.RANDOM_DELAYS then
                    task.wait(math.random(0.1, 0.5))
                end
            end
            
            -- استراحة كل 50 كائن
            if i % 50 == 0 and StealthTechniques.RANDOM_DELAYS then
                task.wait(math.random(0.05, 0.2))
            end
        end
        
        -- استراحة بين المناطق
        if areaIndex < #searchAreas and StealthTechniques.RANDOM_DELAYS then
            task.wait(math.random(0.3, 1.0))
        end
    end
    
    return found
end

-- 🐌 الحقن البطيء جداً
local function slowInject(tokenObj)
    print("🐌 [INJECT] بدء الحقن البطيء...")
    
    local startTime = os.clock()
    
    -- المرحلة 1: الاستعداد (وهمي)
    if StealthTechniques.FAKE_ACTIVITY then
        for i = 1, math.random(3, 8) do
            local temp = Instance.new("NumberValue")
            temp.Name = "Temp_" .. i
            temp.Value = i
            temp.Parent = workspace
            task.wait(0.05)
            temp:Destroy()
        end
    end
    
    -- المرحلة 2: تعديل تدريجي (إن كان رقمياً)
    if tokenObj.type == "NumberValue" then
        local original = tokenObj.object.Value
        local steps = math.random(5, 20)  -- خطوات عشوائية
        
        print("📈 التعديل بـ " .. steps .. " خطوة...")
        
        if StealthTechniques.PARTIAL_MODIFICATION then
            -- تغيير جزئي أولاً
            local partialValue = math.floor(TARGET_VALUE * 0.3)
            tokenObj.object.Value = partialValue
            table.insert(injectionLog, {
                action = "partial_inject",
                value = partialValue,
                time = os.clock() - startTime
            })
            
            task.wait(math.random(0.5, 1.5))
            
            -- تغيير إلى القيمة الكاملة
            tokenObj.object.Value = TARGET_VALUE
            table.insert(injectionLog, {
                action = "full_inject",
                value = TARGET_VALUE,
                time = os.clock() - startTime
            })
        else
            -- تغيير مباشر (أسرع)
            tokenObj.object.Value = TARGET_VALUE
        end
        
    elseif tokenObj.type == "StringValue" then
        -- لو كان نصاً، نغير جزء منه فقط
        local current = tokenObj.object.Value
        if StealthTechniques.PARTIAL_MODIFICATION then
            tokenObj.object.Value = current .. "_999999"
        else
            tokenObj.object.Value = "999999"
        end
    end
    
    local endTime = os.clock()
    return {
        success = true,
        original = tokenObj.original,
        new = tokenObj.object.Value,
        duration = endTime - startTime,
        stealth_used = StealthTechniques
    }
end

-- 🎮 النظام الرئيسي
local function startStealthInjection()
    print([[
    
    ╔══════════════════════════════╗
    ║     🐢 SLOW INJECTOR v2.0    ║
    ║     STEALTH MODE: ACTIVE     ║
    ╚══════════════════════════════╝
    
    🎯 الهدف: تغيير Token/Tokens إلى 999999
    🕵️‍♂️ النمط: بطيء ومتخفي
    ⏱️  الوقت المقدر: 5-15 ثانية
    
    ]])
    
    -- البحث البطيء
    local tokens = stealthFindTokens()
    
    if #tokens == 0 then
        print("❌ لم يتم العثور على Token/Tokens")
        return
    end
    
    print("✅ تم العثور على " .. #tokens .. " Token/Tokens")
    
    -- حقن كل واحد ببطء
    for i, token in ipairs(tokens) do
        print("\n🎯 [" .. i .. "/" .. #tokens .. "] معالجة: " .. token.path)
        print("   النوع: " .. token.type .. " | القيمة الأصلية: " .. tostring(token.original))
        
        -- استراحة بين العمليات
        if i > 1 and StealthTechniques.RANDOM_DELAYS then
            local waitTime = math.random(1, 3)
            print("⏳ انتظار " .. waitTime .. " ثانية...")
            task.wait(waitTime)
        end
        
        -- الحقن البطيء
        local result = slowInject(token)
        
        if result.success then
            print("✅ تم التغيير:")
            print("   من: " .. tostring(result.original))
            print("   إلى: " .. tostring(result.new))
            print("   المدة: " .. string.format("%.2f", result.duration) .. " ثانية")
        end
    end
    
    -- تقرير نهائي
    print("\n" .. string.rep("=", 40))
    print("📊 تقرير الحقن المتخفي:")
    print("   Tokens معالجة: " .. #tokens)
    print("   التقنيات المستخدمة:")
    for tech, enabled in pairs(StealthTechniques) do
        print("   • " .. tech .. ": " .. (enabled and "✅" or "❌"))
    end
    
    -- محاكاة رد النظام (للتجربة فقط)
    task.wait(2)
    print("\n🛡️ محاكاة استجابة النظام:")
    
    if #tokens > 3 then
        print("   ⚠️ النظام اكتشف: تعديلات كثيرة")
        print("   ⏱️ زمن الاكتشاف: 8-12 ثانية")
    else
        print("   ✅ النظام: لم يكتشف (محتمل)")
        print("   🎯 السبب: نمط بطيء/بشري")
    end
end

-- 📱 واجهة الموبايل المتخفية
local function createStealthMobileUI()
    local ui = Instance.new("ScreenGui")
    ui.Name = "CalculatorWidget"  -- اسم عادي للتخفي
    ui.ResetOnSpawn = false
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.4, 0, 0.3, 0)
    main.Position = UDim2.new(0.3, 0, 0.35, 0)
    main.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    main.BackgroundTransparency = 0.1
    
    -- تمويه كأنه آلة حاسبة
    local title = Instance.new("TextLabel")
    title.Text = "CALC"
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    title.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    
    local display = Instance.new("TextBox")
    display.Text = "999999"
    display.Size = UDim2.new(0.8, 0, 0.2, 0)
    display.Position = UDim2.new(0.1, 0, 0.25, 0)
    display.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    display.TextColor3 = Color3.new(1, 1, 1)
    
    local injectBtn = Instance.new("TextButton")
    injectBtn.Text = "CALCULATE"
    injectBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
    injectBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
    injectBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
    injectBtn.TextColor3 = Color3.new(1, 1, 1)
    
    -- حدث الحقن المتخفي
    injectBtn.MouseButton1Click:Connect(function()
        injectBtn.Text = "PROCESSING..."
        injectBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 60)
        
        task.spawn(function()
            startStealthInjection()
            
            task.wait(1)
            injectBtn.Text = "CALCULATE"
            injectBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
        end)
    end)
    
    -- التجميع
    title.Parent = main
    display.Parent = main
    injectBtn.Parent = main
    main.Parent = ui
    
    return ui
end

-- 🚀 البدء مع تأخير (متخفي)
task.wait(3)  -- انتظار أولي
local stealthUI = createStealthMobileUI()
stealthUI.Parent = plr:WaitForChild("PlayerGui")

print("\n🎭 تم تحميل الواجهة المتخفية")
print("   تبدو كآلة حاسبة عادية")
print("   اضغط CALCULATE للبدء")
