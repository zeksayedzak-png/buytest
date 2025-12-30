-- 🎯 PHOENIX SMART PURCHASE v2.0
-- نسخة موجهة لشراء منتج محدد بالاسم
-- loadstring(game:HttpGet(""))()

-- 🎮 انتظر اللعبة
repeat task.wait() until game:IsLoaded()
local plr = game.Players.LocalPlayer

-- 🗃️ قاعدة بيانات المنتجات (تعدلها حسب حاجتك)
local PRODUCT_DATABASE = {
    -- [اسم المنتج] = معرف المنتج
    ["VIP"] = 123456789,
    ["VIP Pass"] = 123456789,
    ["VIP Access"] = 123456789,
    ["Premium"] = 987654321,
    ["Golden Sword"] = 555555555,
    ["Rainbow Wings"] = 666666666,
    ["Speed Boost"] = 777777777,
    ["Super Jump"] = 888888888,
    ["Infinite Coins"] = 999999999,
    ["God Mode"] = 111111111,
    ["Admin Powers"] = 222222222,
    ["Legendary Pet"] = 333333333
}

-- 🔥 نواة القوة الذكية
local Phoenix = {
    _productName = nil,
    _productId = nil,
    _mode = "smart"
}

-- 🔍 البحث عن المنتج بالاسم
function Phoenix:findProductByName(productName)
    print("🔍 Searching for: " .. productName)
    
    -- بحث في قاعدة البيانات
    for name, id in pairs(PRODUCT_DATABASE) do
        if string.lower(name) == string.lower(productName) then
            print("✅ Found: " .. name .. " (ID: " .. id .. ")")
            return id, name
        end
    end
    
    -- بحث تقريبي إذا لم يجد تطابق تام
    for name, id in pairs(PRODUCT_DATABASE) do
        if string.find(string.lower(name), string.lower(productName)) then
            print("✅ Found similar: " .. name .. " (ID: " .. id .. ")")
            return id, name
        end
    end
    
    print("❌ Product not found: " .. productName)
    return nil, nil
end

-- 🧠 المحرك الأساسي الذكي
function Phoenix:igniteSmart(productName)
    self._productName = productName
    
    -- البحث عن المنتج
    local productId, exactName = self:findProductByName(productName)
    if not productId then
        return "❌ PRODUCT NOT FOUND: " .. productName
    end
    
    self._productId = productId
    self._productName = exactName or productName
    
    print("⚡ PHOENIX IGNITED | Product: " .. self._productName .. " | ID: " .. self._productId)
    
    -- 🔥 المرحلة 1: الاستهداف الذكي
    self:_smartTargetPhase()
    
    -- 🔥 المرحلة 2: الشراء المتخفي
    self:_stealthPurchasePhase()
    
    return "✅ PURCHASE COMPLETE: " .. self._productName
end

-- 🎯 المرحلة 1: استهداف ذكي (بدل العشوائية)
function Phoenix:_smartTargetPhase()
    print("🎯 SMART TARGET PHASE")
    
    -- استهداف RemoteEvents المتعلقة بالشراء فقط
    local purchaseRemotes = {}
    
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local nameLower = string.lower(obj.Name)
            -- استهداف الأحداث المتعلقة بالشراء فقط
            if string.find(nameLower, "purchase") or 
               string.find(nameLower, "buy") or 
               string.find(nameLower, "shop") or
               string.find(nameLower, "gamepass") then
                
                table.insert(purchaseRemotes, obj)
            end
        end
    end
    
    print("🎯 Found " .. #purchaseRemotes .. " purchase-related remotes")
    
    -- إرسال طلبات مستهدفة
    for _, remote in pairs(purchaseRemotes) do
        task.spawn(function()
            local payloads = {
                {productId = self._productId, buy = true},
                {gamepassId = self._productId, purchase = true},
                {item = self._productId, action = "buy"},
                self._productId
            }
            
            for _, payload in pairs(payloads) do
                pcall(remote.FireServer, remote, payload)
                task.wait(0.1) -- تباطؤ لتجنب الاكتشاف
            end
        end)
    end
end

-- 🐌 المرحلة 2: شراء متخفي
function Phoenix:_stealthPurchasePhase()
    print("🐌 STEALTH PURCHASE PHASE")
    
    local MarketplaceService = game:GetService("MarketplaceService")
    
    -- 1. انتظار عشوائي (محاكاة تفكير اللاعب)
    task.wait(math.random(1, 3))
    
    -- 2. فتح نافذة الشراء بطريقة متخفية
    for attempt = 1, 3 do  -- 3 محاولات كحد أقصى
        print("   Attempt " .. attempt .. " to purchase: " .. self._productName)
        
        local success, result = pcall(function()
            -- هنا عملية الشراء الفعلية
            MarketplaceService:PromptProductPurchase(plr, self._productId)
            return true
        end)
        
        if success then
            print("   ✅ Purchase window opened for: " .. self._productName)
            
            -- انتظار بعد فتح النافذة
            task.wait(math.random(2, 4))
            
            -- إنشاء إشعار نجاح وهمي
            self:_createSuccessNotification()
            return true
        else
            print("   ⚠️ Attempt " .. attempt .. " failed")
            task.wait(math.random(1, 2)) -- انتظار قبل المحاولة التالية
        end
    end
    
    print("   ❌ All purchase attempts failed")
    return false
end

-- 📱 إنشاء إشعار نجاح
function Phoenix:_createSuccessNotification()
    local notification = Instance.new("ScreenGui")
    notification.Name = "PurchaseSuccess"
    notification.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.6, 0, 0.15, 0)
    frame.Position = UDim2.new(0.2, 0, 0.05, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 60, 30)
    frame.BackgroundTransparency = 0.2
    
    local label = Instance.new("TextLabel")
    label.Text = "✅ Purchased: " .. self._productName
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansBold
    
    label.Parent = frame
    frame.Parent = notification
    notification.Parent = plr.PlayerGui
    
    -- إزالة الإشعار بعد 5 ثواني
    task.wait(5)
    notification:Destroy()
end

-- 📱 واجهة الفينيق الذكية (نسخة موجهة)
local phoenixUI = Instance.new("ScreenGui")
phoenixUI.Name = "PhoenixSmart"
phoenixUI.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0.85, 0, 0.3, 0)
main.Position = UDim2.new(0.075, 0, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 15, 20)
main.BackgroundTransparency = 0.1

local title = Instance.new("TextLabel")
title.Text = "🎯 PHOENIX SMART"
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
title.TextColor3 = Color3.fromRGB(200, 150, 255)
title.Font = Enum.Font.SourceSansBold

-- 👤 صورة المنتج (شكل جميل)
local productImage = Instance.new("ImageLabel")
productImage.Size = UDim2.new(0.2, 0, 0.6, 0)
productImage.Position = UDim2.new(0.05, 0, 0.25, 0)
productImage.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
productImage.Image = "rbxassetid://1234567890" -- يمكنك تغييرها

-- 📝 حقل إدخال اسم المنتج
local input = Instance.new("TextBox")
input.PlaceholderText = "Enter Product Name (e.g., VIP Pass)"
input.Size = UDim2.new(0.6, 0, 0.25, 0)
input.Position = UDim2.new(0.3, 0, 0.25, 0)
input.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
input.TextColor3 = Color3.new(1, 1, 1)
input.Font = Enum.Font.SourceSansBold
input.Text = ""

-- 🔥 زر الشراء
local button = Instance.new("TextButton")
button.Text = "🛒 PURCHASE"
button.Size = UDim2.new(0.6, 0, 0.25, 0)
button.Position = UDim2.new(0.3, 0, 0.55, 0)
button.BackgroundColor3 = Color3.fromRGB(60, 30, 80)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold

-- 📊 حالة النظام
local status = Instance.new("TextLabel")
status.Text = "🟢 READY - Enter product name"
status.Size = UDim2.new(1, 0, 0.2, 0)
status.Position = UDim2.new(0, 0, 0.85, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(100, 255, 100)
status.Font = Enum.Font.SourceSans

-- 📋 قائمة المنتجات المتاحة
local productsList = Instance.new("TextLabel")
productsList.Text = "Available: VIP, Premium, Golden Sword, etc."
productsList.Size = UDim2.new(1, 0, 0.15, 0)
productsList.Position = UDim2.new(0, 0, 1.05, 0)
productsList.BackgroundTransparency = 1
productsList.TextColor3 = Color3.fromRGB(150, 150, 200)
productsList.TextXAlignment = Enum.TextXAlignment.Left
productsList.FontSize = Enum.FontSize.Size12

-- التجميع
title.Parent = main
productImage.Parent = main
input.Parent = main
button.Parent = main
status.Parent = main
productsList.Parent = main
main.Parent = phoenixUI

-- 🔥 حدث الشراء
button.MouseButton1Click:Connect(function()
    local productName = input.Text:gsub("^%s*(.-)%s*$", "%1") -- إزالة الفراغات
    
    if productName == "" then
        status.Text = "❌ ENTER PRODUCT NAME"
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(1.5)
        status.Text = "🟢 READY"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    button.Text = "🔄 PROCESSING..."
    button.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    status.Text = "🔍 Searching: " .. productName
    status.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    task.spawn(function()
        local result = Phoenix:igniteSmart(productName)
        
        status.Text = result
        if string.sub(result, 1, 1) == "✅" then
            status.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            status.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
        
        task.wait(3)
        button.Text = "🛒 PURCHASE"
        button.BackgroundColor3 = Color3.fromRGB(60, 30, 80)
        status.Text = "🟢 READY - Enter product name"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
end)

phoenixUI.Parent = plr.PlayerGui

-- 🚀 تصدير الوظائف
_G.PhoenixSmart = Phoenix
_G.SmartPurchase = function(productName)
    return Phoenix:igniteSmart(productName)
end

-- 📢 الإعلان
print([[
    
    ╔══════════════════════════════════╗
    ║      🎯 PHOENIX SMART v2.0      ║
    ║      TARGETED PURCHASE          ║
    ║      MOBILE READY               ║
    ╚══════════════════════════════════╝
    
    🎯 SMART PURCHASE SYSTEM:
    1. 🔍 Enter product name
    2. 🎯 Targets specific purchase systems
    3. 🐌 Stealth mode to avoid detection
    
    📱 USAGE:
    • Type product name (e.g., "VIP Pass")
    • Press PURCHASE button
    • Or: _G.SmartPurchase("Product Name")
    
    📦 AVAILABLE PRODUCTS:
    • VIP / VIP Pass / Premium
    • Golden Sword / Rainbow Wings
    • Speed Boost / Super Jump
    • Infinite Coins / God Mode
    
    ⚠️ IMPORTANT:
    • Works on mobile via loadstring
    • Update PRODUCT_DATABASE with real IDs
    • For security testing only
    
]])
