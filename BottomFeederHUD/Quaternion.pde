class Quaternion
{
    float w, x, y, z;
}

float[] GetEulerAngles(Quaternion q)
{
    float[] angles;
    angles = new float[3];
    float w2 = q.w*q.w;
    float x2 = q.x*q.x;
    float y2 = q.y*q.y;
    float z2 = q.z*q.z;
    float unitLength = w2 + x2 + y2 + z2;    // Normalised == 1, otherwise correction divisor.
    float abcd = q.w*q.x + q.y*q.z;
    float eps = 1e-7;    // TODO: pick from your math lib instead of hardcoding.
    float pi = 3.14159265358979323846;   // TODO: pick from your math lib instead of hardcoding.
    if (abcd > (0.5-eps)*unitLength)
    {
        angles[0] = 2 * atan2(q.y, q.w);
        angles[1] = pi;
        angles[2] = 0;
    }
    else if (abcd < (-0.5+eps)*unitLength)
    {
        angles[0] = -2 * atan2(q.y, q.w);
        angles[1] = -pi;
        angles[2] = 0;
    }
    else
    {
        float adbc = q.w*q.z - q.x*q.y;
        float acbd = q.w*q.y - q.x*q.z;
        angles[0] = atan2(2*adbc, 1 - 2*(z2+x2));
        angles[1] = asin(2*abcd/unitLength);
        angles[2] = atan2(2*acbd, 1 - 2*(y2+x2));
    }
    return angles;
}
