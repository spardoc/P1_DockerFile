// src/app/chat/chat.component.ts
import { Component, OnInit } from '@angular/core';
import { SocketService } from 'src/app/services/socket.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.scss']
})
export class ChatComponent implements OnInit {
  messages: { text: string, isLocal: boolean }[] = [];
  newMessage: string = '';
  isDarkMode: boolean = false;  // Añadir esta línea

  constructor(private socketService: SocketService) {}

  ngOnInit(): void {
    this.socketService.onNewMessage((message: string) => {
      this.messages.push({ text: message, isLocal: false }); // Asumir que todos los mensajes entrantes no son locales
    });
  }

  // Envía un nuevo mensaje
  sendMessage(): void {
    if (this.newMessage.trim()) {
      this.socketService.sendMessage(this.newMessage);
      this.messages.push({ text: this.newMessage, isLocal: true }); // Marcar los mensajes enviados como locales
      this.newMessage = '';
    }
  }
  toggleDarkMode(): void {  // Añadir este método
    this.isDarkMode = !this.isDarkMode;
  }
}
