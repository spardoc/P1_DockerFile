import { Component } from '@angular/core';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss']
})
export class MenuComponent {
  isMenuVisible: boolean = false;
  pages = [
    {title: 'Chat', path: 'pages/chat'}
  ]
  rutaDinamica = 'pages/chat';

  constructor() { }

  ngOnInit(): void {
  }

  toggleMenu() {
    this.isMenuVisible = !this.isMenuVisible;
  }

  cambiarRuta(nuevaRuta: string) {
    this.rutaDinamica = nuevaRuta;
}
}
