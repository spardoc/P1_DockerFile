import { Injectable } from '@angular/core';
import { io } from 'socket.io-client';

@Injectable({
  providedIn: 'root'
})
export class SocketService {
  private socket: any;

  constructor() {
    // Conecta con el servidor backend (ajusta la URL según tu entorno)
    this.socket = io('http://localhost:3000');
  }

  // Envía un mensaje al servidor
  sendMessage(message: string): void {
    this.socket.emit('message', message);
  }

  // Escucha los mensajes provenientes del servidor
  onNewMessage(callback: (message: string) => void): void {
    this.socket.on('message', callback);
  }
}
