# 🚀 Quick Start Guide

## Get Your App Running in 5 Minutes!

### Step 1: Create Supabase Project (2 min)

1. Go to https://app.supabase.com
2. Click **"New Project"**
3. Fill in:
   - Name: `lost-found-app`
   - Database Password: (choose a strong password)
   - Region: (closest to you)
4. Click **"Create new project"**
5. Wait 2-3 minutes for project creation

### Step 2: Get Credentials (1 min)

1. In your Supabase project, click **Settings** (gear icon)
2. Click **API**
3. Copy these two values:
   - **Project URL** (e.g., `https://xxxxx.supabase.co`)
   - **anon public** key (long string under "Project API keys")

### Step 3: Update Config (30 seconds)

1. Open `lib/supabase/supabase_config.dart`
2. Replace line 7:
   ```dart
   static const String supabaseUrl = 'YOUR_SUPABASE_URL';
   ```
   with your Project URL

3. Replace line 8:
   ```dart
   static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   ```
   with your anon key

4. **Save the file!**

### Step 4: Setup Database (1 min)

1. In Supabase, go to **SQL Editor**
2. Click **"+ New query"**
3. Open `supabase_setup.sql` from your project folder
4. Copy ALL the contents (Ctrl+A, Ctrl+C)
5. Paste into SQL Editor
6. Click **"Run"** (or press F5)
7. You should see: "Success. No rows returned"

### Step 5: Create Storage (30 seconds)

1. In Supabase, go to **Storage**
2. Click **"+ New bucket"**
3. Name: `item-images` (must be exact!)
4. Check ✅ **"Public bucket"**
5. Click **"Create bucket"**

### Step 6: Enable Auth (30 seconds)

1. In Supabase, go to **Authentication**
2. Click **"Providers"**
3. Make sure **Email** is enabled (it should be by default)
4. Click **"Settings"** (in the Authentication section)
5. Scroll down to "Email Auth Settings"
6. Turn OFF "Enable email confirmations" (for testing)
7. Click **"Save"**

### Step 7: Run the App! (30 seconds)

```bash
# For Web
flutter run -d chrome

# For Windows
flutter run -d windows

# For Android (with device connected)
flutter run
```

---

## 🎯 Test It!

1. **Sign Up**: Create account with any email (e.g., test@example.com)
2. **Add Item**: Go to "Add" tab, create a lost/found item
3. **View**: Check "Lost" or "Found" tab to see your item
4. **Details**: Click item to view full details
5. **Profile**: Check profile, then logout

---

## ❌ Troubleshooting

**Error: "Invalid API key"**
- Double-check you copied the correct URL and Anon Key
- Make sure there are no extra spaces

**Error: "relation items does not exist"**
- Run the SQL script from Step 4

**Error: "bucket not found"**
- Create the `item-images` bucket from Step 5
- Make sure it's exactly `item-images` (with hyphen, lowercase)

**Can't sign up**
- Make sure Email provider is enabled (Step 6)
- Disable email confirmations (Step 6)

---

## 📖 More Help?

- **Detailed Guide**: See `SUPABASE_MIGRATION_GUIDE.md`
- **Checklist**: See `SETUP_CHECKLIST.md`
- **README**: See `README.md`

---

**That's it! Your app should now be running with Supabase! 🎉**
