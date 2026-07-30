-- =============================================================
-- Label untuk notifikasi berjenjang (urgency) obat mendekati kedaluwarsa
-- Jalankan pada database `apotik_alang`.
-- =============================================================
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('day',        'day',         'hari'),
('days',       'days',        'hari'),
('week',       'week',        'minggu'),
('month',      'month',       'bulan'),
('days_left',  'Time Left',   'Sisa Waktu'),
('urgency',    'Status',      'Status Urgensi');
