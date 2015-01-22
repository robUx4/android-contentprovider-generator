<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.content.ContentValues;
import android.support.annotation.NonNull;

public interface DatabaseSerializer<MODEL extends BaseModel, CURSOR extends AbstractCursor> {
    @NonNull
    ContentValues getContentValuesFromData(@NonNull MODEL data, boolean update);

    @NonNull
    MODEL getValueFromCursor(CURSOR cursor);
}
