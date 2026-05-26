## Reset hasła roota

1. **Restart**, w menu GRUB-a zatrzymujemy autoboot (klawisz dowolny w pierwszych ~5 s).
2. Na podświetlonym wpisie wciskamy <kbd>e</kbd>.
3. Znajdujemy linię zaczynającą się od `linux` (kiedyś było `linux16`). Na końcu dopisujemy:

   ```
   rd.break enforcing=0
   ```

4. Bootujemy edytowany wpis: <kbd>Ctrl</kbd>+<kbd>X</kbd>.
5. Otrzymujemy shell `switch_root:/#`. Główny system jest zamontowany w `/sysroot`, **read-only**. Remountujemy go z `rw`:

   ```
   switch_root:/# mount -o remount,rw /sysroot
   ```

6. Przechodzimy do niego:

   ```
   switch_root:/# chroot /sysroot
   ```

7. Zmieniamy hasło:

   ```
   sh-4.4# passwd root
   ```

8. Zaznaczamy potrzebę przeetykietowania SELinux-a (inaczej `/etc/shadow` dostanie zły kontekst i nie zalogujesz się):

   ```
   sh-4.4# touch /.autorelabel
   ```

9. Wyjście i reboot:

   ```
   sh-4.4# exit
   switch_root:/# exit
   ```
