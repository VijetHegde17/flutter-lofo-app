-- ========================================
-- Lost & Found App - Supabase Database Setup
-- ========================================
-- Run this entire script in Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → Paste and Run)

-- 1. Create items table
CREATE TABLE IF NOT EXISTS items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  location TEXT NOT NULL,
  contact TEXT NOT NULL,
  image_url TEXT,
  type TEXT NOT NULL CHECK (type IN ('lost', 'found')),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- 2. Enable Row Level Security
ALTER TABLE items ENABLE ROW LEVEL SECURITY;

-- 3. Drop existing policies if they exist (for re-runs)
DROP POLICY IF EXISTS "Items are viewable by everyone" ON items;
DROP POLICY IF EXISTS "Authenticated users can insert items" ON items;

-- 4. Create policies for items table
-- Policy: Anyone authenticated can read all items
CREATE POLICY "Items are viewable by everyone" 
ON items FOR SELECT 
TO authenticated 
USING (true);

-- Policy: Authenticated users can insert their own items
CREATE POLICY "Authenticated users can insert items" 
ON items FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

-- 5. Create indexes for better query performance
CREATE INDEX IF NOT EXISTS items_type_idx ON items(type);
CREATE INDEX IF NOT EXISTS items_created_at_idx ON items(created_at DESC);
CREATE INDEX IF NOT EXISTS items_user_id_idx ON items(user_id);

-- 6. Storage policies for item-images bucket
-- Note: You must create the 'item-images' bucket manually first!
-- (Go to Storage → New bucket → Name: "item-images" → Public: YES)

-- Drop existing storage policies if they exist
DROP POLICY IF EXISTS "Allow authenticated users to upload" ON storage.objects;
DROP POLICY IF EXISTS "Allow public to read images" ON storage.objects;

-- Policy: Allow authenticated users to upload images
CREATE POLICY "Allow authenticated users to upload"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'item-images');

-- Policy: Allow anyone to read images (public access)
CREATE POLICY "Allow public to read images"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'item-images');

-- ========================================
-- Setup Complete! ✅
-- ========================================
-- Next steps:
-- 1. Verify the 'item-images' storage bucket exists
-- 2. Make sure it's set to PUBLIC
-- 3. Update your supabase_config.dart with your credentials
-- 4. Run your Flutter app!
