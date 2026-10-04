import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteCard extends StatelessWidget {

  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  NoteCard({
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(bottom: 15),

      padding: EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: note.isPinned
            ? Color(0xFFFFEEF6)
            : Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: note.isPinned
              ? Color(0xFFF1B8D2)
              : Color(0xFFF2E7ED),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              if (note.isPinned)
                Container(
                  padding: EdgeInsets.all(7),

                  decoration: BoxDecoration(
                    color: Color(0xFFF8C8DC),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    Icons.push_pin,
                    size: 16,
                    color: Color(0xFFB85C88),
                  ),
                ),

              if (note.isPinned)
                SizedBox(width: 10),

              Expanded(
                child: Text(
                  note.title,

                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E3440),
                  ),
                ),
              ),

              PopupMenuButton<String>(

                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.grey[600],
                ),

                onSelected: (value) {

                  if (value == 'pin') {
                    onPin();
                  }

                  if (value == 'edit') {
                    onEdit();
                  }

                  if (value == 'delete') {
                    onDelete();
                  }
                },

                itemBuilder: (context) => [

                  PopupMenuItem(
                    value: 'pin',

                    child: Row(
                      children: [

                        Icon(
                          note.isPinned
                              ? Icons.push_pin_outlined
                              : Icons.push_pin,
                          color: Color(0xFFD98BB6),
                        ),

                        SizedBox(width: 10),

                        Text(
                          note.isPinned
                              ? 'Unpin Note'
                              : 'Pin Note',
                        ),
                      ],
                    ),
                  ),

                  PopupMenuItem(
                    value: 'edit',

                    child: Row(
                      children: [

                        Icon(
                          Icons.edit_outlined,
                          color: Color(0xFFD98BB6),
                        ),

                        SizedBox(width: 10),

                        Text('Edit Note'),
                      ],
                    ),
                  ),

                  PopupMenuItem(
                    value: 'delete',

                    child: Row(
                      children: [

                        Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),

                        SizedBox(width: 10),

                        Text('Delete Note'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12),

          Text(
            note.content,

            maxLines: 4,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF756B73),
              height: 1.5,
            ),
          ),

          SizedBox(height: 14),

          Row(
            children: [

              Icon(
                Icons.access_time,
                size: 14,
                color: Colors.grey[400],
              ),

              SizedBox(width: 5),

              Text(
                '${note.date.day}/${note.date.month}/${note.date.year}',

                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}