# ✅ Supabase Setup Checklist

Use this checklist to ensure you've completed all setup steps correctly.

## 📋 Pre-Migration Cleanup

- [ ] Backup your current Firebase project (optional)
- [ ] Note down any existing user accounts (for testing)

## 🚀 Supabase Project Setup

### Account & Project
- [ ] Create Supabase account at [app.supabase.com](https://app.supabase.com)
- [ ] Create new project: `lost-found-app`
- [ ] Note down Project URL
- [ ] Note down Anon Key

### Configuration
- [ ] Open `lib/supabase/supabase_config.dart`
- [ ] Replace `YOUR_SUPABASE_URL` with your Project URL
- [ ] Replace `YOUR_SUPABASE_ANON_KEY` with your Anon Key
- [ ] Save the file

## 🗄️ Database Setup

### Run SQL Script
- [ ] Go to Supabase Dashboard → SQL Editor
- [ ] Click "+ New query"
- [ ] Open `supabase_setup.sql` from project root
- [ ] Copy entire contents
- [ ] Paste in SQL Editor
- [ ] Click "Run" button
- [ ] Verify success message (should see "Success. No rows returned")

### Verify Tables
- [ ] Go to Supabase Dashboard → Table Editor
- [ ] Confirm `items` table exists
- [ ] Click on `items` table
- [ ] Verify columns: id, title, description, location, contact, image_url, type, user_id, created_at

### Verify Policies
- [ ] In Table Editor, click `items` table
- [ ] Go to "Policies" tab
- [ ] Confirm policy: "Items are viewable by everyone"
- [ ] Confirm policy: "Authenticated users can insert items"

## 📦 Storage Setup

### Create Bucket
- [ ] Go to Supabase Dashboard → Storage
- [ ] Click "+ New bucket"
- [ ] Name: `item-images` (exactly this!)
- [ ] Set as Public bucket: ✅
- [ ] Click "Create bucket"

### Verify Policies
- [ ] Click on `item-images` bucket
- [ ] Go to "Policies" tab
- [ ] Confirm policy: "Allow authenticated users to upload"
- [ ] Confirm policy: "Allow public to read images"

## 🔐 Authentication Setup

### Enable Email Auth
- [ ] Go to Supabase Dashboard → Authentication
- [ ] Click "Providers"
- [ ] Verify "Email" is enabled ✅

### Disable Email Confirmation (Development Only)
- [ ] Go to Authentication → Settings
- [ ] Scroll to "Email Auth Settings"
- [ ] Turn OFF "Enable email confirmations"
- [ ] Click "Save"

⚠️ **Note**: For production, you should enable email confirmations!

## 📱 Flutter App Setup

### Dependencies
- [ ] Open terminal in project directory
- [ ] Run: `flutter pub get`
- [ ] Verify no errors

### Clean Build
- [ ] Run: `flutter clean`
- [ ] Run: `flutter pub get` again

## 🧪 Testing

### Create Test Account
- [ ] Run app: `flutter run -d chrome` (or your preferred platform)
- [ ] Click "Create an account"
- [ ] Sign up with test email: `test@example.com`
- [ ] Password: any password (6+ characters)
- [ ] Verify successful signup and auto-login

### Test Add Item
- [ ] Click "Add" tab
- [ ] Select "Lost" or "Found"
- [ ] Fill in:
  - Title: "Test Item"
  - Description: "This is a test item"
  - Location: "Test Location"
  - Contact: "1234567890"
- [ ] Click "Upload image" (optional)
- [ ] Click "Publish item"
- [ ] Verify success message

### Test View Items
- [ ] Go to "Lost" tab
- [ ] Verify your test item appears
- [ ] Click on the item
- [ ] Verify all details display correctly
- [ ] Verify image displays (if uploaded)

### Test Profile
- [ ] Go to "Profile" tab
- [ ] Verify email displays correctly
- [ ] Click "Logout"
- [ ] Verify redirected to login screen

### Test Login
- [ ] Login with test account
- [ ] Verify successful login
- [ ] Verify items still appear

## 🎯 Platform Testing

Test on all target platforms:
- [ ] Web (Chrome): `flutter run -d chrome`
- [ ] Windows: `flutter run -d windows`
- [ ] Android: `flutter run` (with device connected)
- [ ] iOS: `flutter run -d ios` (Mac only)

## 🐛 Troubleshooting

If you encounter issues:

### API Key Error
- [ ] Double-check URL in `supabase_config.dart`
- [ ] Double-check Anon Key in `supabase_config.dart`
- [ ] Ensure no extra spaces or quotes

### Database Error
- [ ] Verify SQL script ran successfully
- [ ] Check Table Editor for `items` table
- [ ] Verify all columns exist

### Storage Error
- [ ] Verify bucket name is exactly `item-images`
- [ ] Verify bucket is set to Public
- [ ] Check storage policies exist

### Auth Error
- [ ] Verify Email provider is enabled
- [ ] If email confirmation is required, check your email
- [ ] Try disabling email confirmation for testing

### Build Error
- [ ] Run `flutter clean`
- [ ] Delete `pubspec.lock`
- [ ] Run `flutter pub get`
- [ ] Try again

## 📊 Verify in Supabase Dashboard

After testing:
- [ ] Go to Authentication → Users
- [ ] Verify test user exists
- [ ] Go to Table Editor → items
- [ ] Verify test item exists with all data
- [ ] Go to Storage → item-images
- [ ] Verify image uploaded (if tested)

## ✨ Production Checklist

Before deploying to production:
- [ ] Enable email confirmations in Auth settings
- [ ] Review and tighten Row Level Security policies
- [ ] Review and tighten Storage policies
- [ ] Set up proper error logging
- [ ] Configure custom email templates
- [ ] Set up production environment variables
- [ ] Remove any test data
- [ ] Test all features thoroughly

---

## 🎉 Congratulations!

If all items are checked, your Flutter Lost & Found app is now fully migrated to Supabase and ready to use!

For issues, see:
- `SUPABASE_MIGRATION_GUIDE.md` - Detailed migration guide
- `README.md` - General app documentation
- [Supabase Docs](https://supabase.com/docs) - Official documentation
