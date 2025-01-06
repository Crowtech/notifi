// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

List<Destination> destinations = <Destination>[
  const Destination(Icons.inbox_rounded, 'Inbox'),
  const Destination(Icons.article_outlined, 'Articles'),
  const Destination(Icons.messenger_outline_rounded, 'Messages'),
  // Destination(Icons.group_outlined, 'Groups'),
  const Destination(Icons.play_arrow_outlined, 'Play'),
  const Destination(Icons.map_outlined, "Map"),
  const Destination(Icons.door_back_door_outlined, "Logout"),
];
