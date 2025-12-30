-- 🎯 PRECISION INJECTOR v3.0
-- يستهدف مسار محدد: ReplicatedStorage.Modules.TradeTokens.TokenShopUIController.TokenProducts
-- ⚠️ للبيئات الآمنة فقط

local plr = game.Players.LocalPlayer
local TARGET_VALUE = 999999
local injectionLog = {}

-- 🗺️ المسار المحدد
local TARGET_PATH = "ReplicatedStorage.Modules.TradeTokens.TokenShopUIController.TokenProducts"

-- 🔧 إعدادات التخفي
local StealthConfig = {
    MODE = "ULTRA_SLOW",  -- ULTRA_SLOW, SLOW, NORMAL
    FAKE_ACTIVITY = true,
    RANDOM_PATHS = true,  -- يمر على مسارات عشوائية أولاً
    MIMIC_HUMAN = true
}

-- 🧭 التنقل الذكي في المسار
local function navigateToPath(targetPath)
    print("🧭 [NAVIGATION] البحث عن المسار: " .. targetPath)
    
    local parts = targetPath:split(".")
    local current = game
    
    -- تنقل بطيء مع تسجيل
    for i, part in ipairs(parts) do
        print("   → " .. part)
        
        -- استراحة بين المكونات
        if StealthConfig.MODE == "ULTRA_SLOW" and i > 1 then
            task.wait(math.random(0.2, 0.8))
        end
        
        if current:FindFirstChild(part) then
            current = current:FindFirstChild(part)
        else
            print("❌ جزء مفقود: " .. part)
            return nil
        end
    end
    
    return current
end

-- 🔍 البحث الدقيق عن Token/Tokens في المسار
local function deepScanTokenProducts(folder)
    print("🔍 [DEEP SCAN] مسح عميق للمجلد...")
    
    local tokens = {}
    local scanCount = 0
    
    if not folder then
        print("❌ المجلد غير موجود")
        return tokens
    end
    
    -- مسح كل المحتويات ببطء
    for _, child in pairs(folder:GetChildren()) do
        scanCount = scanCount + 1
        
        -- إضافة فترات انتظار للمسح الطويل
        if scanCount % 5 == 0 and StealthConfig.MODE == "ULTRA_SLOW" then
            task.wait(math.random(0.1, 0.3))
        end
        
        -- البحث عن أي شيء باسم Token
        if child.Name:find("Token") then
            table.insert(tokens, {
                object = child,
                name = child.Name,
                type = child.ClassName,
                path = child:GetFullName(),
                original = child.Value,
                parent = child.Parent.Name
            })
            print("   ✅ عثر على: " .. child.Name .. " (" .. child.ClassName .. ")")
        end
        
        -- إذا كان مجلداً، امسح محتوياته أيضاً
        if child:IsA("Folder") then
            for _, subChild in pairs(child:GetChildren()) do
                if subChild.Name:find("Token") then
                    table.insert(tokens, {
                        object = subChild,
                        name = subChild.Name,
                        type = subChild.ClassName,
                        path = subChild:GetFullName(),
                        original = subChild.Value,
                        parent = child.Name
                    })
                    print("   ✅ عثر على: " .. child.Name .. "/" .. subChild.Name)
                end
            end
        end
    end
    
    return tokens
end

-- 🐌 الحقن فائق البطء للمسار المحدد
local function ultraSlowInjection(tokenObj)
    print("🐌 [ULTRA SLOW] بدء الحقن الفائق البطء...")
    
    local startTime = os.clock()
    local steps = {}
    
    -- الخطوة 1: محاكاة نشاط عادي (وهمي)
    if StealthConfig.FAKE_ACTIVITY then
        print("   🎭 نشاط وهمي...")
        for i = 1, math.random(2, 4) do
            local fakeFrame = Instance.new("Frame")
            fakeFrame.Name = "UI_" .. math.random(100, 999)
            fakeFrame.Size = UDim2.new(0, 10, 0, 10)
            fakeFrame.Parent = plr.PlayerGui
            task.wait(0.15)
            fakeFrame:Destroy()
        end
        table.insert(steps, {action = "fake_activity", time = os.clock() - startTime})
    end
    
    -- الخطوة 2: انتظار عشوائي طويل
    local waitTime = math.random(0.5, 2.0)
    print("   ⏳ انتظار " .. string.format("%.1f", waitTime) .. " ثانية...")
    task.wait(waitTime)
    
    -- الخطوة 3: التعديل الجزئي الأول
    if tokenObj.type == "NumberValue" then
        local partialValue = math.floor(TARGET_VALUE * 0.25)
        print("   📈 تعديل جزئي: " .. tokenObj.original .. " → " .. partialValue)
        
        tokenObj.object.Value = partialValue
        table.insert(steps, {
            action = "partial_25%",
            from = tokenObj.original,
            to = partialValue,
            time = os.clock() - startTime
        })
        
        -- انتظار
        task.wait(math.random(0.8, 1.5))
        
        -- الخطوة 4: التعديل الجزئي الثاني
        partialValue = math.floor(TARGET_VALUE * 0.75)
        print("   📈 تعديل جزئي: → " .. partialValue)
        
        tokenObj.object.Value = partialValue
        table.insert(steps, {
            action = "partial_75%",
            to = partialValue,
            time = os.clock() - startTime
        })
        
        -- انتظار أطول
        task.wait(math.random(1.0, 2.0))
        
        -- الخطوة 5: القيمة النهائية
        print("   🎯 القيمة النهائية: → " .. TARGET_VALUE)
        tokenObj.object.Value = TARGET_VALUE
        table.insert(steps, {
            action = "final_value",
            to = TARGET_VALUE,
            time = os.clock() - startTime
        })
        
    elseif tokenObj.type == "StringValue" then
        -- لو كان نصاً
        if StealthConfig.MIMIC_HUMAN then
            local current = tokenObj.object.Value
            -- إضافة تدريجية
            tokenObj.object.Value = current .. "_mod"
            task.wait(0.5)
            tokenObj.object.Value = current .. "_modified"
            task.wait(0.5)
            tokenObj.object.Value = "999999"
        else
            tokenObj.object.Value = "999999"
        end
    end
    
    local endTime = os.clock()
    return {
        success = true,
        original = tokenObj.original,
        new = tokenObj.object.Value,
        steps = #steps,
        duration = endTime - startTime,
        log = steps
    }
end

-- 🧩 النظام الرئيسي للمسار المحدد
local function executePrecisionInjection()
    print([[
    
    ╔══════════════════════════════╗
    ║   🎯 PRECISION INJECTOR     ║
    ║   TARGET: ]] .. TARGET_PATH .. [[
    ║   MODE: ]] .. StealthConfig.MODE .. [[
    ╚══════════════════════════════╝
    
    🎯 مهمة: تغيير Token/Tokens في مسار محدد
    🕵️‍♂️ النمط: فائق البطء والدقة
    ⏱️  الوقت المتوقع: 15-30 ثانية
    
    ]])
    
    -- 1. التنقل إلى المسار
    local targetFolder = navigateToPath(TARGET_PATH)
    
    if not targetFolder then
        print("❌ فشل في الوصول للمسار المطلوب")
        return
    end
    
    print("✅ وصل إلى: " .. targetFolder:GetFullName())
    print("   النوع: " .. targetFolder.ClassName)
    print("   المحتويات: " .. #targetFolder:GetChildren() .. " عنصر")
    
    -- 2. مسح عميق للمجلد
    task.wait(1)
    local tokens = deepScanTokenProducts(targetFolder)
    
    if #tokens == 0 then
        print("❌ لم يتم العثور على Token/Tokens في هذا المسار")
        print("   جاري البحث في المستويات الفرعية...")
        
        -- بحث أعمق
        for _, child in pairs(targetFolder:GetDescendants()) do
            if child.Name:find("Token") then
                table.insert(tokens, {
                    object = child,
                    name = child.Name,
                    type = child.ClassName,
                    path = child:GetFullName(),
                    original = child.Value
                })
            end
        end
        
        if #tokens == 0 then
            print("❌ لا توجد Token/Tokens في أي مستوى")
            return
        end
    end
    
    print("\n✅ العثور على " .. #tokens .. " Token/Tokens:")
    for i, token in ipairs(tokens) do
        print("   " .. i .. ". " .. token.name .. " (" .. token.type .. ")")
        print("      المسار: " .. token.path)
        print("      القيمة: " .. tostring(token.original))
    end
    
    -- 3. الحقن البطيء لكل Token
    local results = {}
    for i, token in ipairs(tokens) do
        print("\n🎯 [" .. i .. "/" .. #tokens .. "] معالجة: " .. token.name)
        print("   المسار: " .. token.path)
        
        -- استراحة طويلة بين العمليات
        if i > 1 then
            local waitTime = math.random(2, 4)
            print("   ⏳ استراحة " .. waitTime .. " ثواني...")
            task.wait(waitTime)
        end
        
        -- الحقن فائق البطء
        local result = ultraSlowInjection(token)
        table.insert(results, result)
        
        print("   ✅ تم: " .. token.original .. " → " .. result.new)
        print("   ⏱️  المدة: " .. string.format("%.2f", result.duration) .. " ثانية")
        print("   📊 الخطوات: " .. result.steps)
        
        -- تسجيل في اللوغ
        table.insert(injectionLog, {
            target = token.path,
            result = result
        })
    end
    
    -- 📊 التقرير النهائي
    print("\n" .. string.rep("=", 50))
    print("📈 تقرير الحقن الدقيق:")
    print("   المسار المستهدف: " .. TARGET_PATH)
    print("   Tokens معالجة: " .. #tokens)
    print("   إجمالي الوقت: " .. string.format("%.1f", os.clock()) .. " ثانية")
    
    local successCount = 0
    for _, r in ipairs(results) do
        if r.success then successCount = successCount + 1 end
    end
    
    print("   النجاح: " .. successCount .. "/" .. #tokens)
    
    -- 🛡️ تقييم الاكتشاف
    task.wait(2)
    print("\n🛡️ تقييم مخاطر الاكتشاف:")
    
    if #tokens <= 2 then
        print("   ✅ مخاطر منخفضة: عدد قليل من التعديلات")
        print("   ⏱️  الاكتشاف المحتمل: 30+ ثانية")
    elseif StealthConfig.MODE == "ULTRA_SLOW" then
        print("   🟡 مخاطر متوسطة: نمط بطيء جداً")
        print("   ⏱️  الاكتشاف المحتمل: 20-30 ثانية")
    else
        print("   🔴 مخاطر عالية: تعديلات كثيرة")
        print("   ⏱️  الاكتشاف المحتمل: 10-15 ثانية")
    end
    
    return results
end

-- 📱 واجهة دقيقة للمسار المحدد
local function createPrecisionMobileUI()
    local ui = Instance.new("ScreenGui")
    ui.Name = "TokenManager_Mobile"
    ui.ResetOnSpawn = false
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.9, 0, 0.4, 0)
    main.Position = UDim2.new(0.05, 0, 0.3, 0)
    main.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    main.BackgroundTransparency = 0.1
    
    -- معلومات المسار
    local pathLabel = Instance.new("TextLabel")
    pathLabel.Text = "🎯 Target: TokenProducts"
    pathLabel.Size = UDim2.new(1, 0, 0.15, 0)
    pathLabel.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    pathLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
    pathLabel.Font = Enum.Font.SourceSansBold
    
    local pathText = Instance.new("TextLabel")
    pathText.Text = TARGET_PATH
    pathText.Size = UDim2.new(1, 0, 0.15, 0)
    pathText.Position = UDim2.new(0, 0, 0.15, 0)
    pathText.BackgroundTransparency = 1
    pathText.TextColor3 = Color3.fromRGB(150, 200, 255)
    pathText.TextScaled = true
    
    -- أزرار التحكم
    local scanBtn = Instance.new("TextButton")
    scanBtn.Text = "🔍 SCAN PATH"
    scanBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
    scanBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
    scanBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
    scanBtn.TextColor3 = Color3.new(1, 1, 1)
    
    local injectBtn = Instance.new("TextButton")
    injectBtn.Text = "🐌 ULTRA SLOW INJECT"
    injectBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
    injectBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
    injectBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    injectBtn.TextColor3 = Color3.new(1, 1, 1)
    
    -- نتائج
    local resultsBox = Instance.new("TextBox")
    resultsBox.Size = UDim2.new(0.9, 0, 0.2, 0)
    resultsBox.Position = UDim2.new(0.05, 0, 0.82, 0)
    resultsBox.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    resultsBox.TextColor3 = Color3.new(1, 1, 1)
    resultsBox.Text = "Status: Ready"
    resultsBox.MultiLine = true
    resultsBox.TextEditable = false
    
    -- أحداث الأزرار
    scanBtn.MouseButton1Click:Connect(function()
        scanBtn.Text = "SCANNING..."
        resultsBox.Text = "Scanning target path...\n"
        
        task.spawn(function()
            local targetFolder = navigateToPath(TARGET_PATH)
            if targetFolder then
                local tokens = deepScanTokenProducts(targetFolder)
                resultsBox.Text = resultsBox.Text .. "Found: " .. #tokens .. " tokens\n"
                for _, t in ipairs(tokens) do
                    resultsBox.Text = resultsBox.Text .. "• " .. t.name .. "\n"
                end
            else
                resultsBox.Text = "❌ Path not found"
            end
            
            scanBtn.Text = "🔍 SCAN PATH"
        end)
    end)
    
    injectBtn.MouseButton1Click:Connect(function()
        injectBtn.Text = "INJECTING..."
        resultsBox.Text = "🚀 Starting ultra slow injection...\n"
        
        task.spawn(function()
            local results = executePrecisionInjection()
            
            if results then
                resultsBox.Text = resultsBox.Text .. "✅ Injection complete!\n"
                resultsBox.Text = resultsBox.Text .. "Modified: " .. #results .. " tokens\n"
                resultsBox.Text = resultsBox.Text .. "Value: " .. TARGET_VALUE
            else
                resultsBox.Text = resultsBox.Text .. "❌ Injection failed"
            end
            
            injectBtn.Text = "🐌 ULTRA SLOW INJECT"
        end)
    end)
    
    -- التجميع
    pathLabel.Parent = main
    pathText.Parent = main
    scanBtn.Parent = main
    injectBtn.Parent = main
    resultsBox.Parent = main
    main.Parent = ui
    
    return ui
end

-- 🚀 التشغيل التلقائي
task.wait(2)  -- تأخير بدء
local precisionUI = createPrecisionMobileUI()
precisionUI.Parent = plr:WaitForChild("PlayerGui")

print("\n🎯 تم تحميل أداة المسار المحدد")
print("   المسار: " .. TARGET_PATH)
print("   اضغط SCAN PATH أولاً للتأكد")
print("   ثم ULTRA SLOW INJECT للحقن")
